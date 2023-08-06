class FixturesController < ApplicationController
  before_action :set_fixture, only: %i[ show edit update destroy ]
  before_action :set_season, only: %i[ index show edit update destroy ]

  # GET /fixtures or /fixtures.json
  def index
    @pagy_fixtures, @fixtures = pagy_array(fixture_list.to_a, items: 1)

    respond_to do |format|
      format.html 
      format.turbo_stream
    end
  end

  # GET /fixtures/1 or /fixtures/1.json
  def show
    @home_starts = Appearance.home_starts(fixture)
    @away_starts = Appearance.away_starts(fixture)
    @home_substitutes = Appearance.home_subs(fixture)
    @away_substitutes = Appearance.away_subs(fixture)
    @home_yellow_cards = Card.home_yellow_cards(fixture)
    @away_yellow_cards = Card.away_yellow_cards(fixture)
    @home_red_cards = Card.home_red_cards(fixture)
    @away_red_cards = Card.away_red_cards(fixture)
    @home_goals = Goal.home_goals(fixture)
    @away_goals = Goal.away_goals(fixture)
    @goals = fixture.goals
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
    @fixture = Fixture.find(params[:id])
  end

  def set_season
    @season = Season.current_season
  end

  def set_team_season(team_season_id)
    TeamSeason.find(team_season_id)
  end  

  # Only allow a list of trusted parameters through.
  def fixture_params
    params.require(:fixture).permit(:home_team_season_id, :away_team_season_id, :home_score, :away_score, :kick_off, :game_week, :api_football_id, :season_id, :league_id)
  end

  def fixture_list
    Fixture.where(season: season).order(:kick_off).group_by(&:game_week)
  end
end
