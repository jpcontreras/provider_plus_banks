class Provider < ApplicationRecord
  MAX_ROWS_BY_PAGE = 10

  validates :name, presence: true, on: [:create, :update]
  validates :nit, format: { with: /\A([0-9]{9,})-([0-9]{1,})\z/, message: 'invalid format' }, allow_nil: true
  validates :contact_name, presence: true, on: [:create, :update]
  validates :contact_cellphone, :length => { :maximum => 10 }
  validates :account_number, :length => { :maximum => 15 }

  belongs_to :bank

  scope :with_paginate_10, lambda { |page| paginate(page: (page || 1), per_page: MAX_ROWS_BY_PAGE) }

  def bank_name
    self.bank.name if self.bank.present?
  end
end
