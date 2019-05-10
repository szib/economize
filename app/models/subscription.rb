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

  def service_name
    service.name
  end

  def subscription_length_in_months
    start_date = self.start_date
    end_date = if !self.end_date.nil?
                 self.end_date
               else
                 DateTime.now
               end

    length_in_days = (end_date.to_i - start_date.to_i) / (3600 * 24)
    length_in_months = if length_in_days % 30 == 0 || length_in_days == 365 || 366
                         length_in_days / 30
                       else
                         (length_in_days / 30) + 1
                       end
  end

  def billing_dates_array
    start_date = self.start_date
    billing_dates = []
    billing_dates << start_date
    subscription_length_in_months.times do
      billing_dates << billing_dates.last + 1.month
    end
    billing_dates
 end
end
