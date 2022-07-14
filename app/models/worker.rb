class Worker < ApplicationRecord
  include Discard::Model

  validates :name, presence: true, length: { minimum: 2 }

  scope :filter_by_name, ->(name) { where('workers.name like ?', "%#{name}%") }
  scope :order_by_name, ->(direction) { order("workers.name #{direction}") }
end
