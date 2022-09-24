class Bank < ApplicationRecord
  validates :name, presence: true, :length => { :in => 1..50 }

  has_many :providers, dependent: :destroy
end