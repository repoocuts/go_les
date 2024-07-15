# == Schema Information
#
# Table name: head_to_heads
#
#  id                                   :bigint           not null, primary key
#  bookings_received                    :integer          default(0)
#  conceded_against_opponent            :integer          default(0)
#  conceded_away                        :integer          default(0)
#  conceded_home                        :integer          default(0)
#  current_season_fixture_ids           :integer          default([]), is an Array
#  fixture_ids                          :integer          default([]), is an Array
#  fixtures_played                      :integer          default(0)
#  opponent_bookings                    :integer          default(0)
#  opponent_reds                        :integer          default(0)
#  reds_received                        :integer          default(0)
#  scored_against_opponent              :integer          default(0)
#  scored_away                          :integer          default(0)
#  scored_home                          :integer          default(0)
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  current_team_season_id               :integer
#  opponent_id                          :integer          default(0)
#  opponent_top_assist_player_season_id :integer
#  opponent_top_scorer_player_season_id :integer
#  team_id                              :bigint           not null
#  top_assist_player_season_id          :integer
#  top_scorer_player_season_id          :integer
#
# Indexes
#
#  index_head_to_heads_on_fixture_ids  (fixture_ids) USING gin
#  index_head_to_heads_on_team_id      (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id) ON DELETE => cascade
#
require "test_helper"

class HeadToHeadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
