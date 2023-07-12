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
#  season_id           :bigint           not null
#
# Indexes
#
#  index_fixtures_on_league_id  (league_id)
#  index_fixtures_on_season_id  (season_id)
#
# Foreign Keys
#
#  fk_rails_...  (league_id => leagues.id)
#  fk_rails_...  (season_id => seasons.id)
#
require "test_helper"

class FixtureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
