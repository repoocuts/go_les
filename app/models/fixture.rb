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

	belongs_to :season
	belongs_to :league
	belongs_to :season_game_week

	belongs_to :away_team_season, class_name: 'TeamSeason', foreign_key: 'away_team_season_id'
	belongs_to :home_team_season, class_name: 'TeamSeason', foreign_key: 'home_team_season_id'

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
		Rails.cache.fetch("home_team_object", expires_in: 12.hours) do
			home_team_season.team
		end
	end

	def away_team_object
		Rails.cache.fetch("away_team_object", expires_in: 12.hours) do
			away_team_season.team
		end
	end

	def home_team_api_football_id
		home_team_season.team.api_football_id
	end

	def away_team_api_football_id
		away_team_season.team.api_football_id
	end

	def home_team_name
		home_team_season.team.name
	end

	def away_team_name
		away_team_season.team.name
	end

	def home_team_name_acronym
		home_team_season.team.acronym
	end

	def away_team_name_acronym
		away_team_season.team.acronym
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

	def home_or_away_checker(team_season_id)
		return "H" if team_season_id == away_team_season_id

		"A"
	end

	def appearance_for_player_season(player_season_id)
		Rails.cache.fetch("away_team_object", expires_in: 12.hours) do
			return appearances.find_by(player_season_id: player_season_id).first

			self
		end
	end

	def delete_associations
		assists.delete_all
		cards.delete_all
		goals.delete_all
		appearance.delete_all
	end

	def home_starts
		Rails.cache.fetch("home_starts", expires_in: 12.hours) do
			appearances.includes(:player_season).where(appearance_type: 'start', is_home: true)
		end
	end

	def away_starts
		Rails.cache.fetch("away_starts", expires_in: 12.hours) do
			appearances.includes(:player_season).where(appearance_type: 'start', is_home: nil)
		end
	end

	def home_substitute_appearances
		Rails.cache.fetch("home_substitute_appearances", expires_in: 12.hours) do
			appearances.includes(:player_season).where(appearance_type: 'substitute', is_home: true)
		end
	end

	def away_substitute_appearances
		Rails.cache.fetch("away_substitute_appearances", expires_in: 12.hours) do
			appearances.includes(:player_season).where(appearance_type: 'substitute', is_home: nil)
		end
	end

	def home_goals
		Rails.cache.fetch("home_goals", expires_in: 12.hours) do
			goals.includes(:assist, player_season: :player).where(is_home: true)
		end
	end

	def away_goals
		Rails.cache.fetch("away_goals", expires_in: 12.hours) do
			goals.includes(:assist, player_season: :player).where(is_home: nil)
		end
	end

	def home_yellow_cards
		Rails.cache.fetch("home_yellow_cards", expires_in: 12.hours) do
			cards.includes(:player_season).where(card_type: 'yellow', is_home: true)
		end
	end

	def away_yellow_cards
		Rails.cache.fetch("away_yellow_cards", expires_in: 12.hours) do
			cards.includes(:player_season).where(card_type: 'yellow', is_home: nil)
		end
	end

	def home_red_cards
		cards.includes(:player_season).where(card_type: 'red', is_home: true)
	end

	def away_red_cards
		cards.includes(:player_season).where(card_type: 'red', is_home: nil)
	end

	private

	def update_from_api_football_response
		Updaters::FixtureApiCall.new(fixture: self, options: { id: api_football_id }).update_fixture
	end

	def format_kick_off
		kick_off.strftime("%d %b %H:%M")
	end

	def completed?
		kick_off.to_date < Date.current
	end

	def interpolate_final_score
		home_score.to_s + ' - ' + away_score.to_s
	end
end
