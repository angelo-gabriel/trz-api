class ApplicationController < ActionController::API
  include RescueHandler

  def json_render(object, status: :ok)
    render json: object, status: status
  end
end

