# == Schema Information
#
# Table name: fixture_api_responses
#
#  id               :bigint           not null, primary key
#  finished_fixture :jsonb
#  pre_fixture      :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fixture_id       :bigint           not null
#
# Indexes
#
#  index_fixture_api_responses_on_fixture_id  (fixture_id)
#
# Foreign Keys
#
#  fk_rails_...  (fixture_id => fixtures.id)
#
class FixtureApiResponse < ApplicationRecord
	belongs_to :fixture
end
