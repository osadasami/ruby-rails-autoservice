class Worker < ApplicationRecord
  has_many :orders, dependent: :delete_all
  validates :name, presence: true, length: { minimum: 2 }
end
