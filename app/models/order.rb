class Order < ApplicationRecord
  has_many :orders_services
  has_many :services, through: :orders_services
  belongs_to :worker

  validates :customer_name, presence: true
end
