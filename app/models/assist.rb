# == Schema Information
#
# Table name: assists
#
#  id               :bigint           not null, primary key
#  is_home          :boolean
#  minute           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  appearances_id   :bigint           not null
#  fixture_id       :bigint           not null
#  goal_id          :bigint           not null
#  player_season_id :bigint           not null
#  team_season_id   :bigint           not null
#
# Indexes
#
#  index_assists_on_appearances_id    (appearances_id)
#  index_assists_on_fixture_id        (fixture_id)
#  index_assists_on_goal_id           (goal_id)
#  index_assists_on_player_season_id  (player_season_id)
#  index_assists_on_team_season_id    (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (appearances_id => appearances.id)
#  fk_rails_...  (fixture_id => fixtures.id)
#  fk_rails_...  (goal_id => goals.id)
#  fk_rails_...  (player_season_id => player_seasons.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
class Assist < ApplicationRecord
  belongs_to :player_season
  belongs_to :goal
  belongs_to :team_season
  belongs_to :fixture
  belongs_to :appearances
end
