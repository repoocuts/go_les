# == Schema Information
#
# Table name: head_to_heads
#
#  id                                   :bigint           not null, primary key
#  bookings_received                    :integer
#  conceded_against_opponent            :integer
#  conceded_away                        :integer
#  conceded_home                        :integer
#  current_season_fixture_ids           :integer          default([]), is an Array
#  fixture_ids                          :integer          default([]), is an Array
#  fixtures_played                      :integer
#  opponent_bookings                    :integer
#  opponent_reds                        :integer
#  reds_received                        :integer
#  scored_against_opponent              :integer
#  scored_away                          :integer
#  scored_home                          :integer
#  created_at                           :datetime         not null
#  updated_at                           :datetime         not null
#  current_team_season_id               :integer
#  opponent_id                          :integer
#  opponent_top_assist_player_season_id :integer
#  opponent_top_scorer_player_season_id :integer
#  team_id                              :bigint           not null
#  top_assist_player_season_id          :integer
#  top_scorer_player_season_id          :integer
#
# Indexes
#
#  index_head_to_heads_on_team_id  (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id)
#
require "test_helper"

class HeadToHeadTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
