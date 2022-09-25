class Bank::ListInteractor
  include Interactor

  def call
    context.data = Bank.order(name: :desc)
  rescue StandardError => error
    context.fail!(error: error)
  end
end