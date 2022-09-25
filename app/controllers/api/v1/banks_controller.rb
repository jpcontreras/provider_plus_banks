class Api::V1::BanksController < AuthorizeController
  def total
    result = Bank::CountInteractor.call()
    render_interactor(result)
  end

  def index
    result = Bank::ListInteractor.call()
    render_interactor(result)
  end

  def show
    result = Bank::ShowInteractor.call({ id: params[:id] })
    render_interactor(result)
  end

  def create
    result = Bank::CreateInteractor.call({ bank_params: bank_params })
    render_interactor(result)
  end

  def destroy
    result = Bank::DestroyInteractor.call({ id: params[:id] })
    render_interactor(result)
  end

  def update
    result = Bank::UpdateInteractor.call({ id: params[:id], bank_params: bank_params })
    render_interactor(result)
  end

  private
  def bank_params
    params.permit(:name)
  end
end
