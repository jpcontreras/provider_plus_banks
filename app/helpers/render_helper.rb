module RenderHelper
  protected

  def render_api_error(error, status)
    render json: {
      success: false,
      errors: error.message.split(', '),
    }, status: status, content_type: 'application/json'
  end
end