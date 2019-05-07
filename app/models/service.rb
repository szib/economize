class Service < ApplicationRecord
  has_many :subscriptions
  has_many :service_tags
  has_many :price_records

end
