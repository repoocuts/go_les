class SeasonsController < ApplicationController
	before_action :set_country, only: [:show, :scorers_streaming, :assists_streaming, :bookings_streaming, :reds_streaming]
	before_action :set_league, only: [:show, :scorers_streaming, :assists_streaming, :bookings_streaming, :reds_streaming]
	before_action :set_season

	# GET /seasons or /seasons.json
	def index
		@seasons = Season.all
	end

	# GET /seasons/1 or /seasons/1.json
	def show
		@season_table = season.team_seasons.order(points: :desc)
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

		respond_to do |format|
			format.html
			# format.turbo_stream
		end
	end

	# GET /seasons/new
	def new
		@season = Season.new
	end

	# GET /seasons/1/edit
	def edit
	end

	# POST /seasons or /seasons.json
	def create
		@season = Season.new(season_params)

		respond_to do |format|
			if @season.save
				format.html { redirect_to season_url(@season), notice: "Season was successfully created." }
				format.json { render :show, status: :created, location: @season }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @season.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /seasons/1 or /seasons/1.json
	def update
		respond_to do |format|
			if @season.update(season_params)
				format.html { redirect_to season_url(@season), notice: "Season was successfully updated." }
				format.json { render :show, status: :ok, location: @season }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @season.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /seasons/1 or /seasons/1.json
	def destroy
		@season.destroy

		respond_to do |format|
			format.html { redirect_to seasons_url, notice: "Season was successfully destroyed." }
			format.json { head :no_content }
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

	def bookings_streaming
		@pagy_booked, @most_booked = pagy_array(season.top_booked, page: params[:page])
		respond_to do |format|
			format.turbo_stream
		end
	end

	def reds_streaming
		@pagy_reds, @most_reds = pagy_array(season.top_reds, page: params[:page])
		respond_to do |format|
			format.turbo_stream
		end
	end

	private

	attr_reader :season, :league, :country
	# Use callbacks to share common setup or constraints between actions.
	def set_season
		@season = league.seasons.friendly.find(params[:id]) || league.seasons.friendly.find(params[:season_id])
	end

	def set_league
		@league = country.leagues.friendly.find(params[:league_id])
	end

	def set_country
		@country = Country.friendly.find(params[:country_id])
	end

	# Only allow a list of trusted parameters through.
	def season_params
		params.require(:season).permit(:start_date, :end_date, :api_football_id, :current_season, :current_game_week, :league_id)
	end
end
