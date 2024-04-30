# == Schema Information
#
# Table name: fixtures
#
#  id                  :bigint           not null, primary key
#  away_score          :integer
#  game_week           :integer
#  home_score          :integer
#  kick_off            :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  api_football_id     :integer
#  away_team_season_id :integer
#  home_team_season_id :integer
#  league_id           :bigint           not null
#  season_game_week_id :bigint
#  season_id           :bigint           not null
#
# Indexes
#
#  index_fixtures_on_away_score           (away_score)
#  index_fixtures_on_away_team_season_id  (away_team_season_id)
#  index_fixtures_on_game_week            (game_week)
#  index_fixtures_on_home_score           (home_score)
#  index_fixtures_on_home_team_season_id  (home_team_season_id)
#  index_fixtures_on_kick_off             (kick_off)
#  index_fixtures_on_league_id            (league_id)
#  index_fixtures_on_season_game_week_id  (season_game_week_id)
#  index_fixtures_on_season_id            (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (league_id => leagues.id)
#  fk_rails_...  (season_game_week_id => season_game_weeks.id)
#  fk_rails_...  (season_id => seasons.id)
#
class Fixture < ApplicationRecord
	has_many :appearances
	has_many :goals
	has_many :cards
	has_many :assists
	has_many :home_starts, -> { where(is_home: true, appearance_type: 'start') }, class_name: 'Appearance'
	has_many :away_starts, -> { where(is_home: false, appearance_type: 'start') }, class_name: 'Appearance'
	has_many :home_goals_with_player_season_and_assist, -> { includes(:player_season, :assist) }, class_name: 'Goal'
	has_many :away_goals_with_player_season_and_assist, -> { includes(:player_season, :assist) }, class_name: 'Goal'
	has_many :home_assists_with_player_season, -> { includes(:player_season) }, class_name: 'Assist'
	has_many :away_assists_with_player_season, -> { includes(:player_season) }, class_name: 'Assist'
	has_many :yellow_cards, -> { where(cards: { card_type: 'yellow' }) }, class_name: "Card", counter_cache: true, foreign_key: "team_season_id"
	has_many :red_cards, -> { where(cards: { card_type: 'red' }) }, class_name: "Card", counter_cache: true, foreign_key: "team_season_id"

	has_one :fixture_api_response
	has_one :referee_fixture

	belongs_to :season
	belongs_to :league
	belongs_to :season_game_week

	belongs_to :away_team_season, class_name: 'TeamSeason', foreign_key: 'away_team_season_id'
	belongs_to :home_team_season, class_name: 'TeamSeason', foreign_key: 'home_team_season_id'

	scope :with_teams, -> { includes(:home_team_season => :team, :away_team_season => :team) }

	scope :for_game_week, ->(season, game_week_number) {
		joins(:season_game_week)
			.where(season: season, season_game_weeks: { game_week_number: game_week_number })
			.order(:kick_off)
	}

	scope :next_seven_days, -> { where(kick_off: Time.zone.now..Time.zone.now + 7.days) }

	def update_stats_post_match
		update_from_api_football_response
	end

	def update_home_starts
		updater_fixture_home_starts.update_fixture_home_starts(self)
	end

	def update_away_starts
		updater_fixture_away_starts.update_fixture_away_starts(self)
	end

	def home_team_object
		home_team_season.team
	end

	def away_team_object
		away_team_season.team
	end

	def home_team_api_football_id
		home_team_season.team.api_football_id
	end

	def away_team_api_football_id
		away_team_season.team.api_football_id
	end

	def home_team_name
		home_team_season.name
	end

	def away_team_name
		away_team_season.name
	end

	def home_team_name_acronym
		home_team_season.acronym
	end

	def away_team_name_acronym
		away_team_season.acronym
	end

	def has_completed?
		kick_off.to_date < Date.current
	end

	def kick_off_or_score
		completed? ? interpolate_final_score : format_kick_off
	end

	def readable_kick_off
		format_kick_off
	end

	def opponent_for_team_season(team_season_id)
		return home_team_name if team_season_id == away_team_season_id

		away_team_name
	end

	def opponent_team_season_object(team_season_id)
		team_season_id == home_team_season_id ? away_team_season : home_team_season
	end

	def home_or_away_checker(team_season_id)
		return "H" if team_season_id == away_team_season_id

		"A"
	end

	def appearance_for_player_season(player_season_id)
		return appearances.find_by(player_season_id: player_season_id)

		self
	end

	def delete_associations
		assists.delete_all
		cards.delete_all
		goals.delete_all
		appearance.delete_all
	end

	def home_starts
		appearances.includes(:player_season).where(appearance_type: 'start', is_home: true)
	end

	def away_starts
		appearances.includes(:player_season).where(appearance_type: 'start', is_home: nil)
	end

	def home_substitute_appearances
		appearances.includes(:player_season).where(appearance_type: 'substitute', is_home: true)
	end

	def away_substitute_appearances
		appearances.includes(:player_season).where(appearance_type: 'substitute', is_home: nil)
	end

	def home_goals
		goals.includes(:assist, player_season: :player).where(is_home: true)
	end

	def away_goals
		goals.includes(:assist, player_season: :player).where(is_home: nil)
	end

	def home_yellow_cards
		cards.includes(:player_season).where(card_type: 'yellow', is_home: true)
	end

	def away_yellow_cards
		cards.includes(:player_season).where(card_type: 'yellow', is_home: nil)
	end

	def home_red_cards
		cards.includes(:player_season).where(card_type: 'red', is_home: true)
	end

	def away_red_cards
		cards.includes(:player_season).where(card_type: 'red', is_home: nil)
	end

	def return_opponent_fixture_string(team_season_id)
		"#{self.opponent_for_team_season(team_season_id)} (#{self.home_or_away_checker(team_season_id)})"
	end

	def return_appearance_minutes_for_player_season(player_season_id)
		appearance = appearances.find_by(player_season_id: player_season_id)
		return 0 unless appearance

		appearance.minutes
	end

	def return_goals_for_player_season(player_season_id)
		0 || appearances.find_by(player_season_id: player_season_id).goals_count
	end

	def return_assists_for_player_season(player_season_id)
		0 || appearances.find_by(player_season_id: player_season_id).assists_count
	end

	def return_yellow_cards_for_player_season(player_season_id)
		0 || appearances.find_by(player_season_id: player_season_id).cards.where(card_type: 'yellow').size
	end

	def return_red_cards_for_player_season(player_season_id)
		0 || appearances.find_by(player_season_id: player_season_id).cards.where(card_type: 'red').size
	end

	private

	def update_from_api_football_response
		Updaters::FixtureApiCall.new(fixture: self, options: { id: api_football_id }).update_fixture
	end

	def format_kick_off
		# Define the time zone for British Standard/Summer Time
		british_time_zone = ActiveSupport::TimeZone.new("London")

		# Check if the kick_off time is during British Summer Time (BST)
		in_bst = british_time_zone.period_for_utc(kick_off).dst?

		# If in BST, add one hour to the kick_off time
		kick_off_to_format = in_bst ? kick_off + 1.hour : kick_off

		# Return the formatted string
		kick_off_to_format.strftime("%d %b %H:%M")
	end

	def completed?
		kick_off.to_date < Date.current
	end

	def interpolate_final_score
		home_score.to_s + ' - ' + away_score.to_s
	end
end
