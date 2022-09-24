class Provider < ApplicationRecord
  validates :name, presence: true
  validates :nit, format: { with: /\A([0-9]{9,})-([0-9]{1,})\z/, message: 'invalid format' }
  validates :contact_name
  validates :contact_cellphone, :length => { :maximum => 10 }
  validates :account_number, :length => { :maximum => 15 }

  belongs_to :bank
end
