class Bank::ShowInteractor
  include Interactor

  def call
    bank_id = context.id
    context.data = Bank.find_by_id(bank_id)
    if context.data.blank?
      context.status = :not_found
    end
  rescue StandardError => error
    context.fail!(error: error)
  end
end