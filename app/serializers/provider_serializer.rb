class ProviderSerializer < ActiveModel::Serializer
  attributes :id, :name, :contact_name, :contact_cellphone, :bank_name, :account_number

  def contact_cellphone
    self.is_field_blank?(object.contact_cellphone)
  end

  def account_number
    self.is_field_blank?(object.account_number)
  end

  def bank_name
    object.bank.name if object.bank.present?
  end

  private
  def is_field_blank?(field)
    I18n.t('messages.attributes.provider.blank') if field.blank?
  end
end