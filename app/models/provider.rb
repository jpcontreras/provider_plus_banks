class Provider < ApplicationRecord
  validates :name, presence: true, on: [:create, :update]
  validates :nit, format: { with: /\A([0-9]{9,})-([0-9]{1,})\z/, message: 'invalid format' }, allow_nil: true
  validates :contact_name, presence: true, on: [:create, :update]
  validates :contact_cellphone, :length => { :maximum => 10 }
  validates :account_number, :length => { :maximum => 15 }

  belongs_to :bank

  scope :with_paginate_10, lambda { |page| paginate(page: (page || 1), per_page: 10) }
end
