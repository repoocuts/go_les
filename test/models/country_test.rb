# == Schema Information
#
# Table name: countries
#
#  id              :bigint           not null, primary key
#  code            :string
#  flag            :string
#  hidden          :boolean
#  name            :string
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  api_football_id :integer
#
# Indexes
#
#  index_countries_on_slug  (slug) UNIQUE
#
require "test_helper"

class CountryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
