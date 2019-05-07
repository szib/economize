class Subscription < ApplicationRecord
  belongs_to :account
  belongs_to :service
end
