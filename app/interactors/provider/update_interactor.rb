class Provider::UpdateInteractor
  include Interactor

  def call
    provider_id = context.id
    provider_params = context.provider_params
    provider = Provider.find_by_id(provider_id)
    if provider.present?
      if provider.update!(provider_params)
        context.status = :ok
        context.data = provider
      end
    else
      context.status = :not_found
      context.data = {}
    end
  rescue StandardError => error
    context.fail!(error: error)
  end
end