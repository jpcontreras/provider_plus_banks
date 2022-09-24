class Api::V1::ProvidersController < ApplicationController

  def create
    @provider = Provider.new(provider_params)
    if @provider.save!
      render_success_format(@provider, I18n.t('messages.models.provider.created'), :created)
    end
  rescue => error
    render_api_error(error, :unprocessable_entity)
  end

  private
  def provider_params
    params.permit(:name, :nit, :contact_name, :contact_cellphone, :account_number, :bank_id)
  end
end
