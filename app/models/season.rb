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

	FINAL_GAME_WEEK = 38.freeze
	CURRENT_GAME_WEEK_OFFSET = 0.freeze
	LAST_GAME_WEEK_OFFSET = -1.freeze
	NEXT_GAME_WEEK_OFFSET = 1.freeze

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
		fixtures.left_joins(:appearances)
		.where('kick_off < ? AND appearances.fixture_id IS NULL', 12.hours.ago)
	end

	def fixtures_for_last_game_week
		SeasonGameWeek.fixtures_for_game_week(self, LAST_GAME_WEEK_OFFSET)
	end

	def fixtures_for_current_game_week
		current_season_game_week_fixtures
	end

	def fixtures_for_next_game_week
		SeasonGameWeek.fixtures_for_game_week(self, NEXT_GAME_WEEK_OFFSET)
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

	def current_season_game_week_fixtures
		@current_season_game_week ||= SeasonGameWeek.fixtures_for_game_week(self, CURRENT_GAME_WEEK_OFFSET)
	end

	def rearranged_fixtures
		@rearranged_fixtures ||= fixtures.where('kick_off < ? AND home_score IS NULL', 12.hours.ago).order(:kick_off)
	end
end
