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
class ApiCallCount < ApplicationRecord
	def increment_count
		increment!(:count)
	end

	def reset_count
		update(count: 0)
	end

	def can_make_api_call?(count_required)
		(count + count_required) < 100
	end
end
