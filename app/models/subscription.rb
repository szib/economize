class Subscription < ApplicationRecord
  belongs_to :account
  belongs_to :service

  validates :start_date, presence: true
  validates :account_id, presence: true
  validates :service_id, presence: true

end
