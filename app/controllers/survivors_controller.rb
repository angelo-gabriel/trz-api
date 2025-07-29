class SurvivorsController < ApplicationController
  before_action :set_survivor, only: %i[ show update destroy ]

  # GET /survivors
  def index
    @survivors = Survivor.all

    json_render @survivors
  end

  # GET /survivors/1
  def show
    json_render @survivor
  end

  # POST /survivors
  def create
    @survivor = Survivor.create!(survivor_params)
    json_render @survivor, status: :created
  end

  # PATCH/PUT /survivors/1
  def update
    @survivor.update!(survivor_params)
    json_render @survivor
  end

  # DELETE /survivors/1
  def destroy
    @survivor.destroy!
    json_render @survivor
  end

  def items
    survivor = Survivor.find(params.expect(:id))

    unless survivor
      render json: { error: "Survivor not found" }, status: :not_found
      return
    end

    if survivor.inventory
      render json: survivor.inventory.items, status: :ok
    else
      render json: { error: "No items found for this survivor" }, status: :not_found
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Survivor not found" }, status: :not_found
  rescue => e
    render json: { error: "Unexpected error: #{e.message}" }, status: :internal_server_error
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_survivor
      @survivor = Survivor.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def survivor_params
      params.expect(survivor: [ :name, :age, :gender, :latitude, :longitude ])
    end
end
