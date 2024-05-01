class DefensiveStatsController < ApplicationController
  before_action :set_defensive_stat, only: %i[ show edit update destroy ]

  # GET /defensive_stats or /defensive_stats.json
  def index
    @defensive_stats = DefensiveStat.all
  end

  # GET /defensive_stats/1 or /defensive_stats/1.json
  def show
  end

  # GET /defensive_stats/new
  def new
    @defensive_stat = DefensiveStat.new
  end

  # GET /defensive_stats/1/edit
  def edit
  end

  # POST /defensive_stats or /defensive_stats.json
  def create
    @defensive_stat = DefensiveStat.new(defensive_stat_params)

    respond_to do |format|
      if @defensive_stat.save
        format.html { redirect_to defensive_stat_url(@defensive_stat), notice: "Defensive stat was successfully created." }
        format.json { render :show, status: :created, location: @defensive_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @defensive_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /defensive_stats/1 or /defensive_stats/1.json
  def update
    respond_to do |format|
      if @defensive_stat.update(defensive_stat_params)
        format.html { redirect_to defensive_stat_url(@defensive_stat), notice: "Defensive stat was successfully updated." }
        format.json { render :show, status: :ok, location: @defensive_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @defensive_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /defensive_stats/1 or /defensive_stats/1.json
  def destroy
    @defensive_stat.destroy

    respond_to do |format|
      format.html { redirect_to defensive_stats_url, notice: "Defensive stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_defensive_stat
      @defensive_stat = DefensiveStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def defensive_stat_params
      params.fetch(:defensive_stat, {})
    end
end
