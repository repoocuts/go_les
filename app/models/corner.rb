# == Schema Information
#
# Table name: corners
#
#  id             :bigint           not null, primary key
#  is_first_half  :boolean
#  is_home        :boolean
#  is_second_half :boolean
#  minute         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  fixture_id     :bigint           not null
#  team_season_id :bigint           not null
#
# Indexes
#
#  index_corners_on_fixture_id      (fixture_id)
#  index_corners_on_team_season_id  (team_season_id)
#
# Foreign Keys
#
#  fk_rails_...  (fixture_id => fixtures.id)
#  fk_rails_...  (team_season_id => team_seasons.id)
#
class Corner < ApplicationRecord
end
