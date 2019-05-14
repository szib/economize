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

  def billing_day
    start_date.to_date.day
  end

  def billing_day_in(year: Date.today.year, month: Date.today.month)
    Date.new(year, month, billing_day)
  rescue ArgumentError => e
    Date.new(year, month, 1).end_of_month
  end

  def billing_day_this_month
    billing_day_in(year: Date.today.year, month: Date.today.month)
  end

  def billing_day_last_month
    today = Date.today << 1
    billing_day_in(year: Date.today.year, month: Date.today.month)
  end

  def billing_dates
    dates = [start_date.to_date]
    last_date = end_date&.to_date || Date.today

    loop do
      next_date = dates.last >> 1
      break if next_date > last_date

      dates << next_date
    end
    dates
  end

  def price_on(date)
    service.price_on(date)
  end

  def total_value
    billing_dates.map { |bd| price_on(bd) }.sum
  end

end
