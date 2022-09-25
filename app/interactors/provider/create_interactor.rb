class Provider::CreateInteractor
  include Interactor

  def call
    provider = Provider.new(context.provider_params)
    if provider.save!
      context.data = provider
      context.status = :created
      context.message = I18n.t('messages.models.provider.created')
    end
  rescue StandardError => error
    context.fail!(error: error)
  end
end
