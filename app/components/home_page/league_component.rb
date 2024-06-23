# frozen_string_literal: true

class HomePage::LeagueComponent < ViewComponent::Base

	def initialize(league:)
		@league = league
		@teams = @league.teams.order(:name)
	end

	private

	attr_reader :league, :teams
end
