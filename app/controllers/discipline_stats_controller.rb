class DisciplineStatsController < ApplicationController
  before_action :set_discipline_stat, only: %i[ show edit update destroy ]

  # GET /discipline_stats or /discipline_stats.json
  def index
    @discipline_stats = DisciplineStat.all
  end

  # GET /discipline_stats/1 or /discipline_stats/1.json
  def show
  end

  # GET /discipline_stats/new
  def new
    @discipline_stat = DisciplineStat.new
  end

  # GET /discipline_stats/1/edit
  def edit
  end

  # POST /discipline_stats or /discipline_stats.json
  def create
    @discipline_stat = DisciplineStat.new(discipline_stat_params)

    respond_to do |format|
      if @discipline_stat.save
        format.html { redirect_to discipline_stat_url(@discipline_stat), notice: "Discipline stat was successfully created." }
        format.json { render :show, status: :created, location: @discipline_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @discipline_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /discipline_stats/1 or /discipline_stats/1.json
  def update
    respond_to do |format|
      if @discipline_stat.update(discipline_stat_params)
        format.html { redirect_to discipline_stat_url(@discipline_stat), notice: "Discipline stat was successfully updated." }
        format.json { render :show, status: :ok, location: @discipline_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @discipline_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discipline_stats/1 or /discipline_stats/1.json
  def destroy
    @discipline_stat.destroy

    respond_to do |format|
      format.html { redirect_to discipline_stats_url, notice: "Discipline stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_discipline_stat
      @discipline_stat = DisciplineStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def discipline_stat_params
      params.fetch(:discipline_stat, {})
    end
end
