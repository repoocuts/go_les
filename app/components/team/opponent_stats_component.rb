# frozen_string_literal: true

class Team::OpponentStatsComponent < ViewComponent::Base
	def initialize(next_match, next_opponent)
		@next_match = next_match
		@next_opponent = next_opponent
	end

	private

	attr_reader :next_match, :next_opponent
end
