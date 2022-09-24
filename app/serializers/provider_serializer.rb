class ProviderSerializer < ActiveModel::Serializer
  attributes :id, :name, :contact_name, :contact_cellphone, :bank_name, :account_number

  def bank_name
    object.bank.name if object.bank.present?
  end
end