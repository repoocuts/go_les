# == Schema Information
#
# Table name: attacking_stats
#
#  id                       :bigint           not null, primary key
#  assists_away             :integer
#  assists_away_first_half  :integer
#  assists_away_second_half :integer
#  assists_first_half       :integer
#  assists_home             :integer
#  assists_home_first_half  :integer
#  assists_home_second_half :integer
#  assists_second_half      :integer
#  assists_total            :integer
#  scored_away              :integer
#  scored_away_first_half   :integer
#  scored_away_second_half  :integer
#  scored_first_half        :integer
#  scored_home              :integer
#  scored_home_first_half   :integer
#  scored_home_second_half  :integer
#  scored_second_half       :integer
#  scored_total             :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  player_season_id         :bigint           not null
#
# Indexes
#
#  index_attacking_stats_on_player_season_id  (player_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_season_id => player_seasons.id)
#
require "test_helper"

class AttackingStatTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
