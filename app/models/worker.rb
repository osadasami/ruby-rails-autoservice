class Worker < ApplicationRecord
  include Discard::Model

  validates :name, presence: true, length: { minimum: 2 }
end
