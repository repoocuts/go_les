class DashboardsController < ApplicationController
	include Search
	before_action :set_season

	def index
		if season
			@current_game_week = SeasonGameWeek.fixtures_for_current_game_week(season)
			@next_game_week = SeasonGameWeek.fixtures_for_next_game_week(season)
			@last_game_week = SeasonGameWeek.fixtures_for_last_game_week(season)
			@pagy_scorers, @top_scorers = pagy_array(season.top_scorers)
			@pagy_assists, @top_assists = pagy_array(season.top_assists)
			@pagy_booked, @most_booked = pagy_array(season.top_booked)
			@pagy_reds, @most_reds = pagy_array(season.top_reds)
		end

		respond_to do |format|
			format.html
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
		@season ||= Season.includes(:season_game_weeks, team_seasons: { player_seasons: :player }).find_by(current_season: true)
	end
end
