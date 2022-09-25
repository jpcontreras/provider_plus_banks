class Bank::DestroyInteractor
  include Interactor

  def call
    bank_id = context.id
    bank = Bank.find_by_id(bank_id)
    if bank.present?
      bank.delete
      context.status = :no_content
    else
      context.status = :not_found
    end
    context.data = {}
  rescue StandardError => error
    context.fail!(error: error)
  end
end