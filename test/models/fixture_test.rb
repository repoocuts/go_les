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
require "test_helper"

class FixtureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
