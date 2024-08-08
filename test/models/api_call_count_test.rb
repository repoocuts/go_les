# == Schema Information
#
# Table name: api_call_counts
#
#  id              :bigint           not null, primary key
#  count           :integer
#  last_league_ids :integer          default([]), is an Array
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  last_team_id    :integer
#
require "test_helper"

class ApiCallCountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
