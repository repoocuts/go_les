# frozen_string_literal: true

class Team::TeamVsOpponentComponent < ViewComponent::Base

	def initialize(current_team_season, next_match, next_opponent)
		@current_team_season = current_team_season
		@next_match = next_match
		@next_opponent = next_opponent
	end

	def average_scored
		return 0 if head_to_head_object.scored_against_opponent.zero?

		head_to_head_object.scored_against_opponent / head_to_head_object.fixtures_played
	end

	def average_conceded
		return 0 if head_to_head_object.conceded_against_opponent.zero?

		head_to_head_object.conceded_against_opponent / head_to_head_object.fixtures_played
	end

	def average_bookings_for
		return 0 if head_to_head_object.bookings_received.zero?

		head_to_head_object.bookings_received / head_to_head_object.fixtures_played
	end

	def average_bookings_against
		return 0 if head_to_head_object.opponent_bookings.zero?

		head_to_head_object.opponent_bookings / head_to_head_object.fixtures_played
	end

	private

	attr_reader :current_team_season, :next_match, :next_opponent

	def head_to_head_object
		@head_to_head_object ||= current_team_season.team.head_to_heads.find_by(opponent_id: next_opponent.team.id)
	end
end
