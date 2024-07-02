class TeamsController < ApplicationController
	before_action :set_team, only: %i[ show edit update destroy ]

	# GET /teams or /teams.json
	def index
		@teams = Team.includes(:league).order('teams.name').group_by(&:league)
	end

	# GET /teams/1 or /teams/1.json
	def show
		@players = team.players
		sorting_column = params[:column].presence_in(['full_name', 'position', 'appearances', 'goals', 'yellow_cards', 'red_cards']) || 'position'
		sorting_direction = params[:direction].presence_in(['asc', 'desc']) || 'asc'
		@player_seasons = PlayerSeason.joins(:player).where(player: @players).sorted_by(sorting_column, sorting_direction)
		@current_team_season = current_team_season
		@top_scorer = current_team_season.top_scorer
		@most_booked = current_team_season.most_booked_player
		@most_reds = current_team_season.most_reds_player
		@pagy_team_upcoming_fixtures, @upcoming_fixtures = pagy(current_team_season.upcoming_fixtures.includes(:home_team_season, :away_team_season))
		@pagy_team_finished_fixtures, @finished_fixtures = pagy(current_team_season.completed_fixtures.includes(:home_team_season, :away_team_season), page_param: :page_results)
		@next_match = current_team_season.next_match
		@next_opponent = @next_match&.opponent_team_season_object(@current_team_season.id)
		respond_to do |format|
			format.html
			format.turbo_stream
		end
	end

	# GET /teams/new
	def new
		@team = Team.new
	end

	# GET /teams/1/edit
	def edit
	end

	# POST /teams or /teams.json
	def create
		@team = Team.new(team_params)

		respond_to do |format|
			if @team.save
				format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
				format.json { render :show, status: :created, location: @team }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @team.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /teams/1 or /teams/1.json
	def update
		respond_to do |format|
			if @team.update(team_params)
				format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
				format.json { render :show, status: :ok, location: @team }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @team.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /teams/1 or /teams/1.json
	def destroy
		@team.destroy

		respond_to do |format|
			format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private

	attr_reader :team
	# Use callbacks to share common setup or constraints between actions.
	def set_team
		@team = Team.friendly.find(params[:id])
	end

	def current_team_season
		team.current_team_season
	end

	# Only allow a list of trusted parameters through.
	def team_params
		params.require(:team).permit(:name, :short_name, :acronym, :api_football_id, :league_id)
	end
end
