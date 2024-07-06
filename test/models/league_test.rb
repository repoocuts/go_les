# == Schema Information
#
# Table name: leagues
#
#  id              :bigint           not null, primary key
#  hidden          :boolean
#  logo            :string
#  name            :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#  country_id      :bigint           not null
#
# Indexes
#
#  index_leagues_on_country_id  (country_id)
#  index_leagues_on_slug        (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id) ON DELETE => cascade
#
require "test_helper"

class LeagueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
