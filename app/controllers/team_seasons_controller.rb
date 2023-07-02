class TeamSeasonsController < ApplicationController
  before_action :set_team_season, only: %i[ show edit update destroy ]

  # GET /team_seasons or /team_seasons.json
  def index
    @team_seasons = TeamSeason.all
  end

  # GET /team_seasons/1 or /team_seasons/1.json
  def show
  end

  # GET /team_seasons/new
  def new
    @team_season = TeamSeason.new
  end

  # GET /team_seasons/1/edit
  def edit
  end

  # POST /team_seasons or /team_seasons.json
  def create
    @team_season = TeamSeason.new(team_season_params)

    respond_to do |format|
      if @team_season.save
        format.html { redirect_to team_season_url(@team_season), notice: "Team season was successfully created." }
        format.json { render :show, status: :created, location: @team_season }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_seasons/1 or /team_seasons/1.json
  def update
    respond_to do |format|
      if @team_season.update(team_season_params)
        format.html { redirect_to team_season_url(@team_season), notice: "Team season was successfully updated." }
        format.json { render :show, status: :ok, location: @team_season }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team_season.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_seasons/1 or /team_seasons/1.json
  def destroy
    @team_season.destroy

    respond_to do |format|
      format.html { redirect_to team_seasons_url, notice: "Team season was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_season
      @team_season = TeamSeason.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_season_params
      params.require(:team_season).permit(:api_football_id, :season_id, :team_id)
    end
end
