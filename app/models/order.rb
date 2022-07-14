class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy

  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :customer_name, presence: true

  scope :order_by_date, ->(direction) { order("orders.created_at #{direction}") }
  scope :order_by_customer_name, ->(direction) { order("orders.customer_name #{direction}") }
  scope :order_by_category, ->(direction) { order("categories.name #{direction}") }
  scope :order_by_service, ->(direction) { order("services.name #{direction}") }
  scope :order_by_worker, ->(direction) { order("workers.name #{direction}") }

  scope :filter_by_date_from, -> (date) { where("orders.created_at >= ?", date) }
  scope :filter_by_date_to, -> (date) { where("orders.created_at <= ?", date) }
  scope :filter_by_customer_name, -> (name) { where('customer_name like ?', "%#{name}%") }
  scope :filter_by_category, -> (name) { references(order_items: [{service: :category}]).where('categories.name like ?', "%#{name}%") }
  scope :filter_by_service, -> (name) { references(order_items: :service).where('services.name like ?', "%#{name}%") }
  scope :filter_by_worker, -> (name) { references(order_items: :worker).where('workers.name like ?', "%#{name}%") }
end
