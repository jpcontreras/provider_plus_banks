class HealthController < ApplicationController
  def check
    render json: {
      status: 'Ok'
    }
  end
end
