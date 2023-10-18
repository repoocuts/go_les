class AssistsController < ApplicationController
  before_action :set_assist, only: %i[ show edit update destroy ]

  # GET /assists or /assists.json
  def index
    @assists = Assist.all
  end

  # GET /assists/1 or /assists/1.json
  def show
  end

  # GET /assists/new
  def new
    @assist = Assist.new
  end

  # GET /assists/1/edit
  def edit
  end

  # POST /assists or /assists.json
  def create
    @assist = Assist.new(assist_params)

    respond_to do |format|
      if @assist.save
        format.html { redirect_to assist_url(@assist), notice: "Assist was successfully created." }
        format.json { render :show, status: :created, location: @assist }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assists/1 or /assists/1.json
  def update
    respond_to do |format|
      if @assist.update(assist_params)
        format.html { redirect_to assist_url(@assist), notice: "Assist was successfully updated." }
        format.json { render :show, status: :ok, location: @assist }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assists/1 or /assists/1.json
  def destroy
    @assist.destroy

    respond_to do |format|
      format.html { redirect_to assists_url, notice: "Assist was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assist
      @assist = Assist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def assist_params
      params.require(:assist).permit(:player_season_id, :goal_id, :team_season_id, :fixture_id, :appearances_id, :is_home, :minute)
    end
end
