class AppearancesController < ApplicationController
  before_action :set_appearance, only: %i[ show edit update destroy ]

  # GET /appearances or /appearances.json
  def index
    @appearances = Appearance.all
  end

  # GET /appearances/1 or /appearances/1.json
  def show
  end

  # GET /appearances/new
  def new
    @appearance = Appearance.new
  end

  # GET /appearances/1/edit
  def edit
  end

  # POST /appearances or /appearances.json
  def create
    @appearance = Appearance.new(appearance_params)

    respond_to do |format|
      if @appearance.save
        format.html { redirect_to appearance_url(@appearance), notice: "Appearance was successfully created." }
        format.json { render :show, status: :created, location: @appearance }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appearances/1 or /appearances/1.json
  def update
    respond_to do |format|
      if @appearance.update(appearance_params)
        format.html { redirect_to appearance_url(@appearance), notice: "Appearance was successfully updated." }
        format.json { render :show, status: :ok, location: @appearance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appearance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appearances/1 or /appearances/1.json
  def destroy
    @appearance.destroy

    respond_to do |format|
      format.html { redirect_to appearances_url, notice: "Appearance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appearance
      @appearance = Appearance.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appearance_params
      params.require(:appearance).permit(:minutes, :goal_type, :is_home, :player_season_id)
    end
end
