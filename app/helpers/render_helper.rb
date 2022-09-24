module RenderHelper
  protected

  def render_success_pagination_format(data, serializer)
    render json: {
      success: true,
      data: data.map{ |row| serializer.new(row).as_json },
      pagination: {
        current_page: data.current_page,
        total_pages: data.total_pages,
        previous_page: data.previous_page,
        next_page: data.next_page,
      }
    }, status: :ok
  end

  def render_success_format(data, message='', status=:ok)
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