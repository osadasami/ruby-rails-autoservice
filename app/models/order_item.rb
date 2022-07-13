class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :service
  belongs_to :worker
end
