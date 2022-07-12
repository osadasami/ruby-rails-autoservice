class Service < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }

  belongs_to :category
  has_many :orders_services
  has_many :orders, through: :orders_services
end
