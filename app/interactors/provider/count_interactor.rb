class Provider::CountInteractor
  include Interactor

  def call
    context.data = Provider.select('id').all.count
  rescue StandardError => error
    context.fail!(error: error)
  end
end