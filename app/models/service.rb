class Service < ApplicationRecord
  include Discard::Model

  validates :name, presence: true, length: { minimum: 3 }

  belongs_to :category
end
