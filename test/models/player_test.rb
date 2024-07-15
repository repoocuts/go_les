# == Schema Information
#
# Table name: players
#
#  id              :bigint           not null, primary key
#  full_name       :string
#  position        :string
#  short_name      :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  team_id         :bigint
#
# Indexes
#
#  index_players_on_full_name   (full_name)
#  index_players_on_short_name  (short_name)
#  index_players_on_slug        (slug) UNIQUE
#  index_players_on_team_id     (team_id)
#
# Foreign Keys
#
#  fk_rails_...  (team_id => teams.id) ON DELETE => nullify
#
require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
