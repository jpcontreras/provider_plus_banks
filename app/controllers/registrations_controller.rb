class RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)
    if resource.save!
      render_success_format(resource, I18n.t('messages.models.user.created'), :created)
    end
  rescue => error
    render_api_error(error, :unprocessable_entity)
  end
end