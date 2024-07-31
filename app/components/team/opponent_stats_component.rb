# frozen_string_literal: true

class Team::OpponentStatsComponent < ViewComponent::Base
	def initialize(next_match, next_opponent)
		@next_match = next_match
		@next_opponent = next_opponent
	end

	def last_fixture_opponent_name
		next_opponent.last_fixture_opponent_name || 'N/A'
	end

	def top_scorer
		next_opponent.top_scorer_player_season[1] || 'N/A'
	end

	def most_booked
		next_opponent.most_booked_player_season&.return_name
	end

	def most_reds
		next_opponent.most_reds_player_season&.return_name
	end

	private

	attr_reader :next_match, :next_opponent
end
