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
