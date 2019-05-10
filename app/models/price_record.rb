class PriceRecord < ApplicationRecord
  belongs_to :service
  validates :effective_from, presence: true
  validates :monthly_price, presence: true, numericality: { greater_than: 0 }
end
