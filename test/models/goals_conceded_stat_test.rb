# == Schema Information
#
# Table name: goals_conceded_stats
#
#  id               :bigint           not null, primary key
#  away             :integer          default(0)
#  away_first_half  :integer          default(0)
#  away_second_half :integer          default(0)
#  first_half       :integer          default(0)
#  home             :integer          default(0)
#  home_first_half  :integer          default(0)
#  home_second_half :integer          default(0)
#  second_half      :integer          default(0)
#  total            :integer          default(0)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  team_season_id   :bigint           not null
#
# Indexes
#
#  index_goals_conceded_stats_on_team_season_id  (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_season_id => team_seasons.id)
#
require "test_helper"

class GoalsConcededStatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
