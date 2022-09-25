class ApplicationController < ActionController::API
  include RenderHelper

  def render_interactor(interactor)
    if interactor.failure?
      render_api_error(interactor.error, :unprocessable_entity)
      return
    end
    # Create actions
    if interactor.status == :created
      render_success_format(interactor.data, interactor.message, interactor.status)
      return
    end
    # Show (Not Found) and Destroy actions
    if interactor.status == :not_found or interactor.status == :no_content
      render json: {}, status: interactor.status
      return
    end

    # Index actions and anothers
    render_success_format(interactor.data)
    return
  end
end
