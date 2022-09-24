class Api::V1::ProvidersController < ApplicationController

  def index
    @providers = Provider.with_paginate_10((params[:page] || 1)).order("id desc")
    render_success_pagination_format(@providers, ProviderSerializer)
  end

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
