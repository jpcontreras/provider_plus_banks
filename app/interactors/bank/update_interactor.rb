class Bank::UpdateInteractor
  include Interactor

  def call
    bank_id = context.id
    bank_params = context.bank_params
    bank = Bank.find_by_id(bank_id)
    if bank.present?
      if bank.update!(bank_params)
        context.status = :ok
        context.data = bank
      end
    else
      context.status = :not_found
      context.data = {}
    end
  rescue StandardError => error
    context.fail!(error: error)
  end
end