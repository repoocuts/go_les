# == Schema Information
#
# Table name: player_seasons
#
#  id              :bigint           not null, primary key
#  current_season  :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  player_id       :bigint           not null
#  team_season_id  :bigint           not null
#
# Indexes
#
#  index_player_seasons_on_player_id       (player_id)
#  index_player_seasons_on_team_season_id  (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (player_id => players.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
require "test_helper"

class PlayerSeasonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
