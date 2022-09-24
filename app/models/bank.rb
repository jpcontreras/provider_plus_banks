class Bank < ApplicationRecord
  validates :name, presence: true, :length => { :maximum => 50 }, on: [:create, :update]

  has_many :providers, dependent: :destroy
end