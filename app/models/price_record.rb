class PriceRecord < ApplicationRecord
  belongs_to :service
  validates :effective_from, presence: true
end
