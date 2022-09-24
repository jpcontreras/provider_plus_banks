class Provider < ApplicationRecord
  validates :name, presence: true
  validates :nit, format: { with: /\A([0-9]{9,})-([0-9]{1,})\z/, message: 'invalid format' }, allow_nil: true
  validates :contact_name, presence: true
  validates :contact_cellphone, :length => { :maximum => 10 }
  validates :account_number, :length => { :maximum => 15 }

  belongs_to :bank
end
