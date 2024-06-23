class DashboardsController < ApplicationController
	include Search
	include DashboardsHelper
	before_action :set_season

	def index
		@leagues = League.all.order(:name)

		respond_to do |format|
			format.html
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
		@season ||= Season.find_by(current_season: true, league_id: 1)
	end
end
