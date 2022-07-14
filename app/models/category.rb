class Category < ApplicationRecord
  include Discard::Model

  validates :name, presence: true, length: { minimum: 3 }

  has_many :services, dependent: :delete_all

  scope :filter_by_name, ->(name) { where('categories.name like ?', "%#{name}%") }
  scope :order_by_name, ->(direction) { order("categories.name #{direction}") }
end
