class Category < ApplicationRecord
  include Discard::Model

  validates :name, presence: true, length: { minimum: 3 }

  has_many :services, dependent: :delete_all
end
