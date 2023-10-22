class DashboardsController < ApplicationController

	before_action :set_season

	def index
		if season
			@current_game_week = season.fixtures_for_current_game_week
			@next_game_week = season.fixtures_for_next_game_week
			@pagy_scorers, @top_scorers = pagy_array(season.top_scorers)
			@pagy_assists, @top_assists = pagy_array(season.top_assists)
			@pagy_booked, @most_booked = pagy_array(season.top_booked)
		end

		respond_to do |format|
			format.html
			format.turbo_stream
		end
	end

	private

	attr_reader :season

	def set_season
		@season ||= Season.find_by(current_season: true)
	end
end
