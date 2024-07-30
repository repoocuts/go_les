# == Schema Information
#
# Table name: fixtures
#
#  id                  :bigint           not null, primary key
#  away_corners        :integer
#  away_score          :integer
#  game_week           :integer
#  home_corners        :integer
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
#  index_fixtures_on_away_score                           (away_score)
#  index_fixtures_on_away_team_season_id                  (away_team_season_id)
#  index_fixtures_on_away_team_season_id_and_away_score   (away_team_season_id,away_score)
#  index_fixtures_on_game_week                            (game_week)
#  index_fixtures_on_home_score                           (home_score)
#  index_fixtures_on_home_team_season_id                  (home_team_season_id)
#  index_fixtures_on_home_team_season_id_and_home_score   (home_team_season_id,home_score)
#  index_fixtures_on_kick_off                             (kick_off)
#  index_fixtures_on_kick_off_and_home_score              (kick_off,home_score)
#  index_fixtures_on_league_id                            (league_id)
#  index_fixtures_on_season_game_week_id                  (season_game_week_id)
#  index_fixtures_on_season_id                            (season_id)
#  index_fixtures_on_team_seasons_and_kick_off_and_score  (home_team_season_id,away_team_season_id,kick_off,home_score)
#
# Foreign Keys
#
#  fk_rails_...  (league_id => leagues.id) ON DELETE => cascade
#  fk_rails_...  (season_game_week_id => season_game_weeks.id)
#  fk_rails_...  (season_id => seasons.id)
#
class Fixture < ApplicationRecord
	has_many :appearances, dependent: :destroy
	has_many :goals, dependent: :destroy
	has_many :cards, dependent: :destroy
	has_many :assists, dependent: :destroy
	has_many :home_starts, -> { where(is_home: true, appearance_type: 'start') }, class_name: 'Appearance'
	has_many :away_starts, -> { where(is_home: false, appearance_type: 'start') }, class_name: 'Appearance'
	has_many :home_goals_with_player_season_and_assist, -> { includes(:player_season, :assist) }, class_name: 'Goal'
	has_many :away_goals_with_player_season_and_assist, -> { includes(:player_season, :assist) }, class_name: 'Goal'
	has_many :home_assists_with_player_season, -> { includes(:player_season) }, class_name: 'Assist'
	has_many :away_assists_with_player_season, -> { includes(:player_season) }, class_name: 'Assist'
	has_many :yellow_cards, -> { where(cards: { card_type: 'yellow' }) }, class_name: "Card", counter_cache: true, foreign_key: "team_season_id"
	has_many :red_cards, -> { where(cards: { card_type: 'red' }) }, class_name: "Card", counter_cache: true, foreign_key: "team_season_id"

	has_one :fixture_api_response, dependent: :destroy
	has_one :referee_fixture, dependent: :destroy

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
	scope :for_team_season, ->(team_season_id) {
		where("home_team_season_id = :id OR away_team_season_id = :id", id: team_season_id)
			.order(game_week: :asc, kick_off: :asc)
	}
	scope :next_seven_days, -> { where(kick_off: Time.zone.now..Time.zone.now + 7.days) }

	delegate :current_season, to: :season

	def home_team_object
		home_team_season.team
	end

	def away_team_object
		away_team_season.team
	end

	def home_team_api_football_id
		home_team_season.api_football_id
	end

	def away_team_api_football_id
		away_team_season.api_football_id
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

	def opponent_acronym_for_team_season(team_season_id)
		return home_team_name_acronym if team_season_id == away_team_season_id

		away_team_name_acronym
	end

	def home_or_away_checker(team_season_id)
		return "H" if team_season_id == away_team_season_id

		"A"
	end

	def appearance_for_player_season(player_season_id)
		return appearances.find_by(player_season_id: player_season_id)

		self
	end

	def home_starts
		appearances.home_starts.includes(:player_season)
	end

	def away_starts
		appearances.away_starts.includes(:player_season)
	end

	def home_substitute_appearances
		appearances.home_subs.includes(:player_season)
	end

	def away_substitute_appearances
		appearances.away_subs.includes(:player_season)
	end

	def home_goals
		goals.home_goals.includes(:assist, player_season: :player)
	end

	def away_goals
		goals.away_goals.includes(:assist, player_season: :player)
	end

	def home_yellow_cards
		cards.home_yellow_cards.includes(:player_season)
	end

	def away_yellow_cards
		cards.away_yellow_cards.includes(:player_season)
	end

	def home_red_cards
		cards.home_red_cards.includes(:player_season)
	end

	def away_red_cards
		cards.away_red_cards.includes(:player_season)
	end

	def return_opponent_fixture_string(team_season_id)
		"#{opponent_for_team_season(team_season_id)} (#{home_or_away_checker(team_season_id)})"
	end

	def return_appearance_minutes_for_player_season(player_season_id)
		appearance = appearances.find_by(player_season_id: player_season_id)
		appearance ? appearance.minutes : 0
	end

	def return_goals_for_player_season(player_season_id)
		appearances.find_by(player_season_id: player_season_id)&.goals_count || 0
	end

	def return_assists_for_player_season(player_season_id)
		appearances.find_by(player_season_id: player_season_id)&.assists_count || 0
	end

	def return_yellow_cards_for_player_season(player_season_id)
		appearances.find_by(player_season_id: player_season_id)&.cards&.where(card_type: 'yellow')&.size || 0
	end

	def return_red_cards_for_player_season(player_season_id)
		appearances.find_by(player_season_id: player_season_id)&.cards&.where(card_type: 'red')&.size || 0
	end

	private

	def format_kick_off
		kick_off_in_user_tz = kick_off.in_time_zone(Time.zone)
		kick_off_in_user_tz.strftime("%d %b %H:%M")
	end

	def completed?
		kick_off.to_date < Date.current
	end

	def interpolate_final_score
		home_score.to_s + ' - ' + away_score.to_s
	end
end
