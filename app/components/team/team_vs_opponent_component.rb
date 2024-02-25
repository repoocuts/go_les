# frozen_string_literal: true

class Team::TeamVsOpponentComponent < ViewComponent::Base

	def initialize(current_team_season, next_match, next_opponent)
		@current_team_season = current_team_season
		@next_match = next_match
		@next_opponent = next_opponent
	end

	private

	attr_reader :current_team_season, :next_match, :next_opponent
end
