class HeadToHeadsController < ApplicationController
  before_action :set_head_to_head, only: %i[ show edit update destroy ]

  # GET /head_to_heads or /head_to_heads.json
  def index
    @head_to_heads = HeadToHead.all
  end

  # GET /head_to_heads/1 or /head_to_heads/1.json
  def show
  end

  # GET /head_to_heads/new
  def new
    @head_to_head = HeadToHead.new
  end

  # GET /head_to_heads/1/edit
  def edit
  end

  # POST /head_to_heads or /head_to_heads.json
  def create
    @head_to_head = HeadToHead.new(head_to_head_params)

    respond_to do |format|
      if @head_to_head.save
        format.html { redirect_to head_to_head_url(@head_to_head), notice: "Head to head was successfully created." }
        format.json { render :show, status: :created, location: @head_to_head }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @head_to_head.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /head_to_heads/1 or /head_to_heads/1.json
  def update
    respond_to do |format|
      if @head_to_head.update(head_to_head_params)
        format.html { redirect_to head_to_head_url(@head_to_head), notice: "Head to head was successfully updated." }
        format.json { render :show, status: :ok, location: @head_to_head }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @head_to_head.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /head_to_heads/1 or /head_to_heads/1.json
  def destroy
    @head_to_head.destroy

    respond_to do |format|
      format.html { redirect_to head_to_heads_url, notice: "Head to head was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_head_to_head
      @head_to_head = HeadToHead.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def head_to_head_params
      params.fetch(:head_to_head, {})
    end
end
