class PlayersController < ApplicationController
	before_action :set_player, only: %i[ show edit update destroy ]
	before_action :set_team_season, only: %i[ show edit update destroy ]
	before_action :set_player_season, only: %i[ show edit update destroy ]

	# GET /players or /players.json
	def index
		@pagy_players, @players = pagy_array(sorted_players, items: 1)

		respond_to do |format|
			format.html
			format.turbo_stream
		end
	end

	# GET /players/1 or /players/1.json
	def show
		@fixtures = @team_season.completed_fixtures_reversed
	end

	# GET /players/new
	def new
		@player = Player.new
	end

	# GET /players/1/edit
	def edit
	end

	# POST /players or /players.json
	def create
		@player = Player.new(player_params)

		respond_to do |format|
			if @player.save
				format.html { redirect_to player_url(@player), notice: "Player was successfully created." }
				format.json { render :show, status: :created, location: @player }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @player.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /players/1 or /players/1.json
	def update
		respond_to do |format|
			if @player.update(player_params)
				format.html { redirect_to player_url(@player), notice: "Player was successfully updated." }
				format.json { render :show, status: :ok, location: @player }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @player.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /players/1 or /players/1.json
	def destroy
		@player.destroy

		respond_to do |format|
			format.html { redirect_to players_url, notice: "Player was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private

	attr_reader :player, :player_season, :team_season
	# Use callbacks to share common setup or constraints between actions.
	def set_player
		@player = Player.friendly.find(params[:id])
	end

	def set_team_season
		season = Season.friendly.find(params[:season_id])
		team = Team.friendly.find(params[:team_id])
		@team_season = TeamSeason.find_by(season:, team:)
	end

	def set_player_season
		@player_season = PlayerSeason.find_by(team_season: @team_season, player: @player)
	end

	# Only allow a list of trusted parameters through.
	def player_params
		params.require(:player).permit(:full_name, :short_name, :position, :api_football_id, :team_id)
	end

	def sorted_players
		Team.includes(:players).order(:name).map do |team|
			{ team_name: team.name, players: team.players.sort_by(&:return_name) }
		end
	end
end
