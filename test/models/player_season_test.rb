# == Schema Information
#
# Table name: player_seasons
#
#  id                :bigint           not null, primary key
#  appearances_count :integer          default(0), not null
#  assists_count     :integer          default(0), not null
#  current_season    :boolean
#  goals_count       :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  api_football_id   :integer
#  player_id         :bigint           not null
#  team_season_id    :bigint           not null
#
# Indexes
#
#  index_player_seasons_on_appearances_count               (appearances_count)
#  index_player_seasons_on_assists_count                   (assists_count)
#  index_player_seasons_on_goals_count                     (goals_count)
#  index_player_seasons_on_player_id                       (player_id)
#  index_player_seasons_on_team_season_id                  (team_season_id)
#  index_player_seasons_on_team_season_id_and_goals_count  (team_season_id,goals_count)
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
