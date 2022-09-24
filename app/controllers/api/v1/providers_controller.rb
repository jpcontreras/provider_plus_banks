class Api::V1::ProvidersController < ApplicationController
  before_action :find_provider, only: %i[show update destroy]

  def index
    @providers = Provider.with_paginate_10((params[:page] || 1)).order("id desc")
    render_success_pagination_format(@providers, ProviderSerializer)
  end

  def show
    if @provider.present?
      render json: @provider, status: :ok
      return
    end
    render json: {}, status: :not_found
  end

  def create
    @provider = Provider.new(provider_params)
    if @provider.save!
      render_success_format(@provider, I18n.t('messages.models.provider.created'), :created)
    end
  rescue => error
    render_api_error(error, :unprocessable_entity)
  end

  def update
    if @provider.present?
      @provider.update(provider_params)
      render json: @provider, status: :ok
      return
    end
    render json: {}, status: :not_found
  end

  private
  def provider_params
    params.permit(:name, :nit, :contact_name, :contact_cellphone, :account_number, :bank_id)
  end

  def find_provider
    @provider = Provider.find_by_id(params[:id])
  end
end
