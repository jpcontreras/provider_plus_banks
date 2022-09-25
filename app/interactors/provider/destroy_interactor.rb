class Provider::DestroyInteractor
  include Interactor

  def call
    provider_id = context.id
    provider = Provider.find_by_id(provider_id)
    if provider.present?
      provider.delete
      context.status = :no_content
    else
      context.status = :not_found
    end
    context.data = {}
  rescue StandardError => error
    context.fail!(error: error)
  end
end