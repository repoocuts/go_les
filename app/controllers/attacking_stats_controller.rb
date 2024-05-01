class AttackingStatsController < ApplicationController
  before_action :set_attacking_stat, only: %i[ show edit update destroy ]

  # GET /attacking_stats or /attacking_stats.json
  def index
    @attacking_stats = AttackingStat.all
  end

  # GET /attacking_stats/1 or /attacking_stats/1.json
  def show
  end

  # GET /attacking_stats/new
  def new
    @attacking_stat = AttackingStat.new
  end

  # GET /attacking_stats/1/edit
  def edit
  end

  # POST /attacking_stats or /attacking_stats.json
  def create
    @attacking_stat = AttackingStat.new(attacking_stat_params)

    respond_to do |format|
      if @attacking_stat.save
        format.html { redirect_to attacking_stat_url(@attacking_stat), notice: "Attacking stat was successfully created." }
        format.json { render :show, status: :created, location: @attacking_stat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attacking_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attacking_stats/1 or /attacking_stats/1.json
  def update
    respond_to do |format|
      if @attacking_stat.update(attacking_stat_params)
        format.html { redirect_to attacking_stat_url(@attacking_stat), notice: "Attacking stat was successfully updated." }
        format.json { render :show, status: :ok, location: @attacking_stat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attacking_stat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attacking_stats/1 or /attacking_stats/1.json
  def destroy
    @attacking_stat.destroy

    respond_to do |format|
      format.html { redirect_to attacking_stats_url, notice: "Attacking stat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attacking_stat
      @attacking_stat = AttackingStat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attacking_stat_params
      params.fetch(:attacking_stat, {})
    end
end
