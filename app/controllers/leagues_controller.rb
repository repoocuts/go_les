class LeaguesController < ApplicationController
	before_action :set_country, only: %i[ show edit update destroy ]
	before_action :set_league, only: %i[ show edit update destroy ]
	before_action :set_season, only: %i[ show edit update destroy ]

	# GET /leagues or /leagues.json
	def index
		@leagues = League.not_hidden.includes(:country).order('countries.name').group_by(&:country)
	end

	# GET /leagues/1 or /leagues/1.json
	def show
		@seasons = league.seasons.order(:years)
		@teams = league.teams.order(:name)
	end

	# GET /leagues/new
	def new
		@league = @country.leagues.build
	end

	# GET /leagues/1/edit
	def edit
	end

	# POST /leagues or /leagues.json
	def create
		@league = @country.leagues.build(league_params)

		respond_to do |format|
			if @league.save
				format.html { redirect_to country_leagues_url(@league), notice: "League was successfully created." }
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
			format.html { redirect_to country_leagues_url(@country), notice: "League was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private

	attr_reader :league, :season, :country
	# Use callbacks to share common setup or constraints between actions.
	def set_league
		@league = League.friendly.find(params[:id])
	end

	def set_season
		@season = league.current_season
	end

	def set_country
		@country = Country.friendly.find(params[:country_id])
	end

	# Only allow a list of trusted parameters through.
	def league_params
		params.require(:league).permit(:name, :api_football_id, :country_id)
	end
end
