# == Schema Information
#
# Table name: appearances
#
#  id               :bigint           not null, primary key
#  appearance_type  :string
#  assists_count    :integer          default(0), not null
#  goals_count      :integer          default(0), not null
#  is_home          :boolean
#  minutes          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fixture_id       :bigint           not null
#  player_season_id :bigint           not null
#  team_season_id   :bigint           not null
#
# Indexes
#
#  index_appearances_on_fixture_id        (fixture_id)
#  index_appearances_on_player_season_id  (player_season_id)
#  index_appearances_on_team_season_id    (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (fixture_id => fixtures.id)
#  fk_rails_...  (player_season_id => player_seasons.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
require "test_helper"

class AppearanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
