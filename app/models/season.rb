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
	has_many :season_game_weeks
	has_many :fixtures
	has_many :team_seasons
	has_many :player_seasons, through: :team_seasons
	has_many :goals, through: :team_seasons
	has_many :assists, through: :goals
	has_many :cards, through: :team_seasons

	scope :current_season, -> { find_by(current_season: true) }

	def next_round_of_fixtures
		fixtures.where(season_id: id, game_week: game_week + 1)
	end

	def completed_fixtures
		fixtures.where('kick_off < ? AND (SELECT COUNT(*) FROM appearances WHERE appearances.fixture_id = fixtures.id) = ?', 12.hours.ago, 0)
	end

	def fixtures_for_current_game_week
		season_game_weeks
		.find_by(game_week_number: current_game_week)
		.fixtures
		.includes(home_team_season: :team, away_team_season: :team)
		.order(:kick_off)
	end

	def fixtures_for_next_game_week
		season_game_weeks
		.find_by(game_week_number: current_game_week + ONE)
		.fixtures
		.includes(home_team_season: :team, away_team_season: :team)
		.order(:kick_off)
	end

	def top_scorers
		grouped_goals = goals.includes(player_season: [:player, { team_season: :team }]).group_by(&:player_season)
		sorted_counts = grouped_goals.map { |player_season, goals| [player_season, goals.count] }
		sorted_counts.sort_by! { |_, count| -count }
	end

	def top_assists
		grouped_assists = assists.includes(player_season: [:player, { team_season: :team }]).group_by(&:player_season)
		sorted_counts = grouped_assists.map { |player_season, assist| [player_season, assist.count] }
		sorted_counts.sort_by! { |_, count| -count }
	end

	def top_booked
		grouped_cards = cards.includes(player_season: [:player, { team_season: :team }]).group_by(&:player_season)
		sorted_counts = grouped_cards.map { |player_season, card| [player_season, card.count] }
		sorted_counts.sort_by! { |_, count| -count }
	end

	private

	def top_scorers_array
		@season_goals ||= Goal.by_season(id)
	end

	def top_assists_array
		@season_assists ||= Assist.by_season(id)
	end

	def top_booked_array
		@season_yellows ||= Card.by_season(id)
	end
end
