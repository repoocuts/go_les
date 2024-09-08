class FixturesController < ApplicationController
	before_action :set_fixture, only: %i[ show edit update destroy ]
	before_action :set_season, only: %i[ show edit update destroy ]

	# GET /fixtures or /fixtures.json
	def index
		@leagues = League.includes(:country).not_hidden.order(:name)
		@fixtures = @leagues.map do |league|
			season = league.current_season
			country_game_week_param = "#{league.country.name.downcase}_game_week"

			current_game_week = (params[country_game_week_param] || default_game_week(season: season)).to_i

			if params[:increment].present?
				current_game_week += params[:increment].to_i
			end

			params[country_game_week_param] = current_game_week

			season.fixtures.includes(home_team_season: :team, away_team_season: :team).for_game_week(season, current_game_week)
		end.flatten

		respond_to do |format|
			format.html
			format.turbo_stream
		end
	end

	# GET /fixtures/1 or /fixtures/1.json
	def show
		@home_starts = fixture.home_starts
		@away_starts = fixture.away_starts
		@home_substitutes = fixture.home_substitute_appearances
		@away_substitutes = fixture.away_substitute_appearances
		@home_yellow_cards = fixture.home_yellow_cards
		@away_yellow_cards = fixture.away_yellow_cards
		@home_red_cards = fixture.home_red_cards
		@away_red_cards = fixture.away_red_cards
		@home_goals = fixture.home_goals.group_by(&:appearance_id)
		@away_goals = fixture.away_goals.group_by(&:appearance_id)
		@goals = fixture.goals.includes(:player_season, :assist)
		@cards = fixture.cards
		@subs = fixture.appearances.where(appearance_type: 'substitute')
		@home_team_season = set_team_season(fixture.home_team_season_id)
		@away_team_season = set_team_season(fixture.away_team_season_id)
	end

	# GET /fixtures/new
	def new
		@fixture = Fixture.new
	end

	# GET /fixtures/1/edit
	def edit
	end

	# POST /fixtures or /fixtures.json
	def create
		@fixture = Fixture.new(fixture_params)

		respond_to do |format|
			if @fixture.save
				format.html { redirect_to fixture_url(@fixture), notice: "Fixture was successfully created." }
				format.json { render :show, status: :created, location: @fixture }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @fixture.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /fixtures/1 or /fixtures/1.json
	def update
		respond_to do |format|
			if @fixture.update(fixture_params)
				format.html { redirect_to fixture_url(@fixture), notice: "Fixture was successfully updated." }
				format.json { render :show, status: :ok, location: @fixture }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @fixture.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /fixtures/1 or /fixtures/1.json
	def destroy
		@fixture.destroy

		respond_to do |format|
			format.html { redirect_to fixtures_url, notice: "Fixture was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private

	attr_reader :fixture, :season
	# Use callbacks to share common setup or constraints between actions.
	def set_fixture
		@fixture = Fixture.includes(:goals,
		                            :cards,
		                            :appearances,
		                            :home_starts,
		                            :away_starts,
		                            :home_goals_with_player_season_and_assist,
		                            :away_goals_with_player_season_and_assist,
		                            :home_assists_with_player_season,
		                            :away_assists_with_player_season,
		                            referee_fixture: [:referee],
		                            home_team_season: [:team],
		                            away_team_season: [:team],
		).find(params[:id])
	end

	def set_season
		@season = fixture.season || Season.friendly.find(params[:season_id])
	end

	def default_game_week(season:)
		season.try(:current_game_week) || 1
	end

	def set_team_season(team_season_id)
		TeamSeason.find(team_season_id)
	end

	# Only allow a list of trusted parameters through.
	def fixture_params
		params.require(:fixture).permit(:home_team_season_id, :away_team_season_id, :home_score, :away_score, :kick_off, :game_week, :api_football_id, :season_id, :league_id)
	end
end
