# == Schema Information
#
# Table name: season_game_weeks
#
#  id               :bigint           not null, primary key
#  game_week_number :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fixture_id       :bigint
#  season_id        :bigint
#
# Indexes
#
#  index_season_game_weeks_on_fixture_id        (fixture_id)
#  index_season_game_weeks_on_game_week_number  (game_week_number)
#  index_season_game_weeks_on_season_id         (season_id)
#
class SeasonGameWeek < ApplicationRecord
	belongs_to :season
	has_many :fixtures

	def self.fixtures_for_current_game_week(season)
		find_by(season: season, game_week_number: season.current_game_week).fixtures.order(:kick_off)
	end

	def self.fixtures_for_last_game_week(season)
		find_by(season: season, game_week_number: season.current_game_week - 1).fixtures.order(:kick_off)
	end

	def self.fixtures_for_next_game_week(season)
		find_by(season: season, game_week_number: season.current_game_week + 1).fixtures.order(:kick_off)
	end

end
