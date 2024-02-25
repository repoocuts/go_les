# frozen_string_literal: true

class Team::OpponentGoalStatsComponent < ViewComponent::Base
	def initialize(next_match, next_opponent)
		@next_match = next_match
		@next_opponent = next_opponent
	end
end
