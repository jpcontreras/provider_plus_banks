module RenderHelper
  protected

  def render_success_format(data, message, status=:ok)
    render json: {
      success: true,
      message: message,
      data: data
    }, status: status
  end

  def render_api_error(error, status)
    render json: {
      success: false,
      errors: error.message.split(', '),
    }, status: status
  end
end