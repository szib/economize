class Service < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :service_tags
  has_many :price_records, dependent: :destroy

  accepts_nested_attributes_for :price_records

  validates :name, presence: true, uniqueness: true

  def oldest_price_record
    price_records&.min_by(&:effective_from)
  end

  def most_recent_price_record
    price_records&.max_by(&:effective_from)
  end

  def current_price
    most_recent_price_record&.monthly_price
  end

  def total_active_subscriptions
    subscriptions.map(&:end_date).select(&:nil?).size
  end

  def account_ids
    subscriptions.map(&:account_id).uniq
  end

  def num_of_users
    subscriptions.map(&:account_id).uniq.count
  end

  def first_subscriber?(account_id)
    Subscription.where('account_id = ? AND service_id = ?', account_id, id).count(:id) == 1
  end

  def returning_customer?(account_id)
    !first_subscriber?(account_id)
  end

  def num_of_returning_users
    account_ids.select { |account_id| returning_customer?(account_id) }.count
  end

  def returning_percentage
    return 0 if num_of_users == 0

    num_of_returning_users / num_of_users.to_f * 100
  end

  def subscription_value
    subscriptions.select(&:active?).map(&:value).sum
  end

  def age_in_days
    (most_recent_price_record.effective_from.to_date - oldest_price_record.effective_from.to_date).to_i
  end

  def monthly_price_increase
    price_diff = most_recent_price_record.monthly_price - oldest_price_record.monthly_price
    return 0 if price_diff == 0

    (price_diff / age_in_days) * 30
  end

  def future_price(months_from_now = 6)
    current_price + (monthly_price_increase * months_from_now)
  end

  # ========================================
  #    METHODS FOR DASHBOARD
  # ========================================

  def self.most_expensive
    Service.all.sort_by(&:current_price).last(10).reverse
  end

  def self.ranked_by_num_of_users
    services = Service.all.sort_by(&:num_of_users).last(10).reverse
  end

  def self.ranked_by_addictiveness
    services = Service.all.sort_by(&:returning_percentage).last(10).reverse
  end

  def self.ranked_by_value
    services = Service.all.sort_by(&:subscription_value).last(10).reverse
  end

  def self.ranked_by_future_price(_limit = nil)
    services = Service.all.sort_by(&:future_price).last(10).reverse
  end
end
