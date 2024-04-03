# == Schema Information
#
# Table name: team_seasons
#
#  id                 :bigint           not null, primary key
#  appearances_count  :integer          default(0), not null
#  assists_count      :integer          default(0), not null
#  current_season     :boolean
#  goals_count        :integer          default(0), not null
#  points             :integer
#  red_cards_count    :integer          default(0), not null
#  yellow_cards_count :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  api_football_id    :integer
#  season_id          :bigint           not null
#  team_id            :bigint           not null
#
# Indexes
#
#  index_team_seasons_on_appearances_count   (appearances_count)
#  index_team_seasons_on_assists_count       (assists_count)
#  index_team_seasons_on_goals_count         (goals_count)
#  index_team_seasons_on_red_cards_count     (red_cards_count)
#  index_team_seasons_on_season_id           (season_id)
#  index_team_seasons_on_team_id             (team_id)
#  index_team_seasons_on_yellow_cards_count  (yellow_cards_count)
#
# Foreign Keys
#
#  fk_rails_...  (season_id => seasons.id)
#  fk_rails_...  (team_id => teams.id)
#
require "test_helper"

class TeamSeasonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
