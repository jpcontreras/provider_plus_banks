class Bank::CountInteractor
  include Interactor

  def call
    context.data = Bank.select('id').all.count
  rescue StandardError => error
    context.fail!(error: error)
  end
end