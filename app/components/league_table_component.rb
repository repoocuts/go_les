# frozen_string_literal: true

class LeagueTableComponent < ViewComponent::Base

	def initialize(season)
		@season = season
	end

	def league_table_order
		season.team_seasons.includes(:team).order(:points).reverse
	end

	private

	attr_reader :season
end
