# == Schema Information
#
# Table name: team_seasons
#
#  id              :bigint           not null, primary key
#  current_season  :boolean
#  points          :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  season_id       :bigint           not null
#  team_id         :bigint           not null
#
# Indexes
#
#  index_team_seasons_on_season_id  (season_id)
#  index_team_seasons_on_team_id    (team_id)
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
