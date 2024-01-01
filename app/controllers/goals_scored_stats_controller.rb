class GoalsScoredStatsController < ApplicationController
  before_action :set_goals_scored_stat, only: %i[ show edit update destroy ]

  # GET /goals_scored_stats or /goals_scored_stats.json
  def index
    @goals_scored_stats = GoalsScoredStat.all
  end

  # GET /goals_scored_stats/1 or /goals_scored_stats/1.json
  def show
  end

  # GET /goals_scored_stats/new
  def new
    @goals_scored_stat = GoalsScoredStat.new
  end

  # GET /goals_scored_stats/1/edit
  def edit
  end

  # POST /goals_scored_stats or /goals_scored_stats.json
  def create
    @goals_scored_stat = GoalsScoredStat.new(goals_scored_stat_params)

    respond_to do |format|
      if @goals_scored_stat.save
        format.html { redirect_to goals_scored_stat_url(@goals_scored_stat), notice: "Goals scored stat was successfully created." }
        format.json { render :show, status: :created, location: @goals_scored_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @goals_scored_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals_scored_stats/1 or /goals_scored_stats/1.json
  def update
    respond_to do |format|
      if @goals_scored_stat.update(goals_scored_stat_params)
        format.html { redirect_to goals_scored_stat_url(@goals_scored_stat), notice: "Goals scored stat was successfully updated." }
        format.json { render :show, status: :ok, location: @goals_scored_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @goals_scored_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals_scored_stats/1 or /goals_scored_stats/1.json
  def destroy
    @goals_scored_stat.destroy

    respond_to do |format|
      format.html { redirect_to goals_scored_stats_url, notice: "Goals scored stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goals_scored_stat
      @goals_scored_stat = GoalsScoredStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def goals_scored_stat_params
      params.fetch(:goals_scored_stat, {})
    end
end
