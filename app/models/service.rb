class Service < ApplicationRecord
  include Discard::Model

  validates :name, presence: true, length: { minimum: 3 }

  belongs_to :category

  scope :order_by_name, ->(direction) { order(name: direction) }
  scope :order_by_category, ->(direction) { order("categories.name #{direction}") }

  scope :filter_by_name, ->(name) { where("services.name like ?", "%#{name}%") }
  scope :filter_by_category, ->(name) { references(:categories).where("categories.name like ?", "%#{name}%") }
end
