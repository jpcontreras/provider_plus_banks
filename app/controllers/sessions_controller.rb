class SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate(auth_options)
    unless self.resource.present?
      raise I18n.t('messages.models.user.sign_in.wrong')
    end
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  rescue => error
    render_api_error(error, :unprocessable_entity)
  end

  private

  def respond_with(resource, _opts={})
    render_success_format(resource, I18n.t('messages.models.user.sign_in.success'), :created)
  end

  def respond_to_on_destroy
    head :no_content
  end
end