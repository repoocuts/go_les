class RefereeFixturesController < ApplicationController
  before_action :set_referee_fixture, only: %i[ show edit update destroy ]

  # GET /referee_fixtures or /referee_fixtures.json
  def index
    @referee_fixtures = RefereeFixture.all
  end

  # GET /referee_fixtures/1 or /referee_fixtures/1.json
  def show
  end

  # GET /referee_fixtures/new
  def new
    @referee_fixture = RefereeFixture.new
  end

  # GET /referee_fixtures/1/edit
  def edit
  end

  # POST /referee_fixtures or /referee_fixtures.json
  def create
    @referee_fixture = RefereeFixture.new(referee_fixture_params)

    respond_to do |format|
      if @referee_fixture.save
        format.html { redirect_to referee_fixture_url(@referee_fixture), notice: "Referee fixture was successfully created." }
        format.json { render :show, status: :created, location: @referee_fixture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @referee_fixture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referee_fixtures/1 or /referee_fixtures/1.json
  def update
    respond_to do |format|
      if @referee_fixture.update(referee_fixture_params)
        format.html { redirect_to referee_fixture_url(@referee_fixture), notice: "Referee fixture was successfully updated." }
        format.json { render :show, status: :ok, location: @referee_fixture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @referee_fixture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referee_fixtures/1 or /referee_fixtures/1.json
  def destroy
    @referee_fixture.destroy

    respond_to do |format|
      format.html { redirect_to referee_fixtures_url, notice: "Referee fixture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referee_fixture
      @referee_fixture = RefereeFixture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def referee_fixture_params
      params.require(:referee_fixture).permit(:fixture_id, :referee_id, :season_id)
    end
end
