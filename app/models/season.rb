# == Schema Information
#
# Table name: seasons
#
#  id                :bigint           not null, primary key
#  current_game_week :integer
#  current_season    :boolean
#  end_date          :datetime
#  slug              :string
#  start_date        :datetime
#  years             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  api_football_id   :integer
#  league_id         :bigint           not null
#
# Indexes
#
#  index_seasons_on_league_id  (league_id)
#  index_seasons_on_slug       (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (league_id => leagues.id) ON DELETE => cascade
#
class Season < ApplicationRecord
	extend FriendlyId
	friendly_id :years, use: :slugged
	ONE = 1.freeze

	belongs_to :league
	has_many :season_game_weeks, dependent: :destroy
	has_many :fixtures, dependent: :destroy
	has_many :team_seasons
	has_many :player_seasons, through: :team_seasons
	has_many :goals, through: :team_seasons
	has_many :assists, through: :goals
	has_many :cards, through: :team_seasons
	has_many :referees, dependent: :destroy
	has_many :referee_fixtures, dependent: :destroy

	scope :current_season, -> { find_by(current_season: true) }
	scope :last_season, ->(start_date) { find_by(start_date: start_date - 1.year) }

	def completed_fixtures
		fixtures.where('kick_off < ? AND (SELECT COUNT(*) FROM appearances WHERE appearances.fixture_id = fixtures.id) = ?', 12.hours.ago, 0)
	end

	def fixtures_for_last_game_week
		return unless last_season_game_week_fixtures

		last_season_game_week_fixtures.includes(home_team_season: :team, away_team_season: :team).order(:kick_off)
	end

	def fixtures_for_current_game_week
		current_season_game_week_fixtures.includes(home_team_season: :team, away_team_season: :team).order(:kick_off)
	end

	def fixtures_for_next_game_week
		return [] if current_game_week == 38

		next_season_game_week_fixtures.includes(home_team_season: :team, away_team_season: :team).order(:kick_off)
	end

	def fixtures_requiring_update
		current_season_game_week_fixtures + rearranged_fixtures
	end

	def top_scorers
		player_seasons.with_goals.order(goals_count: :desc)
	end

	def top_assists
		player_seasons.with_assists.order(assists_count: :desc)
	end

	def top_booked
		player_seasons.booked_players_with_count.to_a.sort_by(&:cards_count).reverse
	end

	def top_reds
		player_seasons.sent_off_players_with_count.to_a.sort_by(&:cards_count).reverse
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

	def current_season_game_week_fixtures
		@current_season_game_week ||= season_game_weeks.find_by(game_week_number: current_game_week).fixtures
	end

	def last_season_game_week_fixtures
		return if current_game_week == 1

		@last_season_game_week ||= season_game_weeks.find_by(game_week_number: current_game_week - 1).fixtures
	end

	def next_season_game_week_fixtures
		return [] if current_game_week == 38

		@next_season_game_week ||= season_game_weeks.find_by(game_week_number: current_game_week + 1).fixtures
	end

	def rearranged_fixtures
		@rearranged_fixtures ||= fixtures.where('kick_off < ? AND home_score IS NULL', 12.hours.ago).order(:kick_off)
	end
end
