class Subscription < ApplicationRecord
  belongs_to :account
  belongs_to :service

  validates :start_date, presence: true
  validate :user_cannot_subscribe_twice, if: :new_subscription?

  def new_subscription?
    id.nil?
  end

  def user_cannot_subscribe_twice
    account = Account.find(account_id)
    subscription = account.subscriptions.find_by(service_id: service_id, end_date: nil)

    errors.add(:base, 'Already subscribed.') if subscription.present?
  end

  def active?
    end_date.nil?
  end

  def cancelled?
    !active?
  end

  def service_name
    service.name
  end

  def value
    service.current_price
  end
end
