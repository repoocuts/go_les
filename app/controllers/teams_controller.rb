class TeamsController < ApplicationController
	before_action :set_team, only: %i[ show edit update destroy ]
	before_action :set_season, only: %i[ show ]
	before_action :set_team_season, only: %i[ show ]

	# GET /teams or /teams.json
	def index
		@teams = Team.joins(:league)
		         .joins(:team_seasons)
		         .where(leagues: { hidden: false })
		         .where(team_seasons: { season_id: League.joins(:seasons).select('seasons.id').where(seasons: { current_season: true }) })
		         .order('teams.name')
		         .group_by(&:league)
	end

	# GET /teams/1 or /teams/1.json
	def show
		@players = team.players
		sorting_column = params[:column].presence_in(%w[full_name position appearances goals yellow_cards red_cards]) || 'position'
		sorting_direction = params[:direction].presence_in(%w[asc desc]) || 'asc'
		@player_seasons = team_season.current_player_seasons.sorted_by(sorting_column, sorting_direction)
		@top_scorer = team_season.top_scorer_player_season
		@most_booked = team_season.most_booked_player_season
		@most_reds = team_season.most_reds_player_season
		@pagy_team_upcoming_fixtures, @upcoming_fixtures = pagy_array(team_season.upcoming_fixtures)
		@pagy_team_finished_fixtures, @finished_fixtures = pagy_array(team_season.completed_fixtures, page_param: :page_results)
		@next_match = team_season.next_fixture
		@next_opponent = @next_match&.opponent_team_season_object(team_season.id)
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

	attr_reader :team, :season, :team_season
	# Use callbacks to share common setup or constraints between actions.
	def set_team
		@team = Team.friendly.find(params[:id])
	end

	def set_season
		@season = if params[:season_id].present?
			          Season.includes(
				          league: :country,
				          team_seasons: [:team, :goals_scored_stat, :goals_conceded_stat, :yellow_cards_stat, :red_cards_stat],
				          fixtures: [:home_team_season, :away_team_season]
			          ).friendly.find(params[:season_id])
			        else
				        team.current_team_season.season
		          end
	end

	def set_team_season
		@team_season = TeamSeason.find_by(team_id: @team.id, season_id: @season.id) || team.current_team_season
	end

	# Only allow a list of trusted parameters through.
	def team_params
		params.require(:team).permit(:name, :short_name, :acronym, :api_football_id, :league_id)
	end
end
