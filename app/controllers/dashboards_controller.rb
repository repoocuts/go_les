class DashboardsController < ApplicationController
	include Search
	include DashboardsHelper
	before_action :set_season

	def index
		if season
			@current_game_week = season.fixtures_for_current_game_week
			@next_game_week = season.fixtures_for_next_game_week
			@last_game_week = season.fixtures_for_last_game_week
			@team_seasons = season.team_seasons
			current_page = params[:page] || 1
			@pagy_scorers, @top_scorers = pagy_countless(season.top_scorers, page: current_page)
			@pagy_assists, @top_assists = pagy_countless(season.top_assists, page: current_page)
			@pagy_booked, @most_booked = pagy_array(season.top_booked, page: current_page)
			@pagy_reds, @most_reds = pagy_array(season.top_reds, page: current_page)
			@next_page = @pagy_scorers.next
		end

		respond_to do |format|
			format.html
			format.turbo_stream
		end
	end

	def scorers_streaming
		@pagy_scorers, @top_scorers = pagy_countless(season.top_scorers, page: params[:page])
		respond_to do |format|
			format.turbo_stream
		end
	end

	def assists_streaming
		@pagy_assists, @top_assists = pagy_countless(season.top_assists, page: params[:page])
		respond_to do |format|
			format.turbo_stream
		end
	end

	def search
		@teams = return_teams(params[:query])
		@players = return_players(params[:query])

		respond_to do |format|
			format.html { render :search_results }
		end
	end

	private

	attr_reader :season, :current_game_week

	def set_season
		@season ||= Season.find_by(current_season: true)
	end
end
