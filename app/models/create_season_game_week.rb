# == Schema Information
#
# Table name: create_season_game_weeks
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
#  index_create_season_game_weeks_on_fixture_id  (fixture_id)
#  index_create_season_game_weeks_on_season_id   (season_id)
#
class CreateSeasonGameWeek < ApplicationRecord
end
