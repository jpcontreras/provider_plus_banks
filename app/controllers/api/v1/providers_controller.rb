class Api::V1::ProvidersController < AuthorizeController
  def total
    result = Provider::CountInteractor.call()
    render_interactor(result)
  end

  def index
    result = Provider::ListInteractor.call({page: params[:page]})
    render_success_pagination_format(result.data, ProviderSerializer)
  end

  def show
    result = Provider::ShowInteractor.call({ id: params[:id] })
    render_interactor(result, ProviderSerializer)
  end

  def create
    result = Provider::CreateInteractor.call({ provider_params: provider_params })
    render_interactor(result)
  end

  def destroy
    result = Provider::DestroyInteractor.call({ id: params[:id] })
    render_interactor(result)
  end

  def update
    result = Provider::UpdateInteractor.call({ id: params[:id], provider_params: provider_params })
    render_interactor(result)
  end

  private
  def provider_params
    params.permit(:name, :nit, :contact_name, :contact_cellphone, :account_number, :bank_id)
  end
end
