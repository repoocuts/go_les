class LeaguesController < ApplicationController
	before_action :set_league, only: %i[ index show edit update destroy ]
	before_action :set_season, only: %i[ index show edit update destroy ]

	# GET /leagues or /leagues.json
	def index
		@league = season.team_seasons.includes(:team).order(:points).reverse
	end

	# GET /leagues/1 or /leagues/1.json
	def show
	end

	# GET /leagues/new
	def new
		@league = League.new
	end

	# GET /leagues/1/edit
	def edit
	end

	# POST /leagues or /leagues.json
	def create
		@league = League.new(league_params)

		respond_to do |format|
			if @league.save
				format.html { redirect_to league_url(@league), notice: "League was successfully created." }
				format.json { render :show, status: :created, location: @league }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @league.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /leagues/1 or /leagues/1.json
	def update
		respond_to do |format|
			if @league.update(league_params)
				format.html { redirect_to league_url(@league), notice: "League was successfully updated." }
				format.json { render :show, status: :ok, location: @league }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @league.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /leagues/1 or /leagues/1.json
	def destroy
		@league.destroy

		respond_to do |format|
			format.html { redirect_to leagues_url, notice: "League was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private

	attr_reader :league, :season
	# Use callbacks to share common setup or constraints between actions.
	def set_league
		@league = League.find(params[:id]) || League.first
	end

	def set_season
		@season = @league.current_season
	end

	# Only allow a list of trusted parameters through.
	def league_params
		params.require(:league).permit(:name, :api_football_id, :country_id)
	end
end
