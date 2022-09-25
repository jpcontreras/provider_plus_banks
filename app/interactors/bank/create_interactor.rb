class Bank::CreateInteractor
  include Interactor

  def call
    bank = Bank.new(context.bank_params)
    if bank.save!
      context.data = bank
      context.status = :created
      context.message = I18n.t('messages.models.bank.created')
    end
  rescue StandardError => error
    context.fail!(error: error)
  end
end