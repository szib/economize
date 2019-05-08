class Service < ApplicationRecord
  has_many :subscriptions
  has_many :service_tags
  has_many :price_records

  validates :name, presence: true, uniqueness: true

  def oldest_price_record
    price_records.min_by(&:effective_from)
  end

  def most_recent_price_record
    price_records.max_by(&:effective_from)
  end

end
