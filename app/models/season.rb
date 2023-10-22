# == Schema Information
#
# Table name: seasons
#
#  id                :bigint           not null, primary key
#  current_game_week :integer
#  current_season    :boolean
#  end_date          :datetime
#  start_date        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  api_football_id   :integer
#  league_id         :bigint           not null
#
# Indexes
#
#  index_seasons_on_league_id  (league_id)
#
# Foreign Keys
#
#  fk_rails_...  (league_id => leagues.id)
#
class Season < ApplicationRecord
	ONE = 1.freeze

	belongs_to :league
	has_many :fixtures
	has_many :team_seasons
	has_many :player_seasons, through: :team_seasons
	has_many :goals, through: :team_seasons

	scope :current_season, -> { find_by(current_season: true) }

	def next_round_of_fixtures
		fixtures.where(season_id: id, game_week: game_week + 1)
	end

	def completed_fixtures
		fixtures.where('kick_off < ? AND (SELECT COUNT(*) FROM appearances WHERE appearances.fixture_id = fixtures.id) = ?', 12.hours.ago, 0)
	end

	def fixtures_for_current_game_week
		fixtures.includes(:home_team_season, :away_team_season).where(game_week: current_game_week).order(:kick_off)
	end

	def fixtures_for_next_game_week
		fixtures.includes(:home_team_season, :away_team_season).where(game_week: current_game_week + ONE).order(:kick_off)
	end

	def top_scorers_array
		Goal.by_season(id)
	end

	def top_scorers
		top_scorers_array.map do |player_season_id, goal_count|
			player_season = PlayerSeason.find(player_season_id) # This line will now not hit the database
			{
				player: player_season.get_player_name,
				team_acronym: player_season.team_acronym,
				team_name: player_season.team_name,
				goals: goal_count,
				player_id: player_season.player_id,
				team_id: player_season.team_season.team_id,
			}
		end
	end

	def top_assists_array
		Assist.by_season(id)
	end

	def top_assists
		top_assists_array.map do |player_season_id, assist_count|
			player_season = PlayerSeason.find(player_season_id)
			{
				player: player_season.get_player_name,
				team_acronym: player_season.team_acronym,
				team_name: player_season.team_name,
				assists: assist_count,
				player_id: player_season.player_id,
				team_id: player_season.team_season.team_id,
			}
		end
	end

	def top_booked_array
		Card.by_season(id)
	end

	def top_booked
		top_booked_array.map do |player_season_id, card_count|
			player_season = PlayerSeason.find(player_season_id)
			{
				player: player_season.get_player_name,
				team_acronym: player_season.team_acronym,
				team_name: player_season.team_name,
				yellow_cards: card_count,
				player_id: player_season.player_id,
				team_id: player_season.team_season.team_id,
			}
		end
	end
end
