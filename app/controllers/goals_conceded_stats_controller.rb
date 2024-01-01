class GoalsConcededStatsController < ApplicationController
  before_action :set_goals_conceded_stat, only: %i[ show edit update destroy ]

  # GET /goals_conceded_stats or /goals_conceded_stats.json
  def index
    @goals_conceded_stats = GoalsConcededStat.all
  end

  # GET /goals_conceded_stats/1 or /goals_conceded_stats/1.json
  def show
  end

  # GET /goals_conceded_stats/new
  def new
    @goals_conceded_stat = GoalsConcededStat.new
  end

  # GET /goals_conceded_stats/1/edit
  def edit
  end

  # POST /goals_conceded_stats or /goals_conceded_stats.json
  def create
    @goals_conceded_stat = GoalsConcededStat.new(goals_conceded_stat_params)

    respond_to do |format|
      if @goals_conceded_stat.save
        format.html { redirect_to goals_conceded_stat_url(@goals_conceded_stat), notice: "Goals conceded stat was successfully created." }
        format.json { render :show, status: :created, location: @goals_conceded_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @goals_conceded_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals_conceded_stats/1 or /goals_conceded_stats/1.json
  def update
    respond_to do |format|
      if @goals_conceded_stat.update(goals_conceded_stat_params)
        format.html { redirect_to goals_conceded_stat_url(@goals_conceded_stat), notice: "Goals conceded stat was successfully updated." }
        format.json { render :show, status: :ok, location: @goals_conceded_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @goals_conceded_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals_conceded_stats/1 or /goals_conceded_stats/1.json
  def destroy
    @goals_conceded_stat.destroy

    respond_to do |format|
      format.html { redirect_to goals_conceded_stats_url, notice: "Goals conceded stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goals_conceded_stat
      @goals_conceded_stat = GoalsConcededStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def goals_conceded_stat_params
      params.fetch(:goals_conceded_stat, {})
    end
end
