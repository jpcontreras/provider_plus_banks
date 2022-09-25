class Provider::ShowInteractor
  include Interactor

  def call
    provider_id = context.id
    context.data = Provider.find_by_id(provider_id)
    if context.data.blank?
      context.status = :not_found
    end
  rescue StandardError => error
    context.fail!(error: error)
  end
end