class Account < ApplicationRecord
  belongs_to :user
  has_many :subscriptions, dependent: :destroy

  def active_subscriptions
    subscriptions.select(&:active?)
  end

  def cancelled_subscriptions
    subscriptions.reject(&:active?)
  end

  def num_of_subs_to(service_id)
    Subscription.where('account_id = ? AND service_id = ?', id, service_id).count(:id) || 0
  end

  def first_subscriber?(service_id)
    num_of_subs_to(service_id) == 1
  end

  def returning_subscriber?(service_id)
    num_of_subs_to(service_id) > 1
  end

  # ========================================
  #    METHODS FOR USER'S DASHBOARD
  # ========================================
  def most_expensive_subscription
    subscriptions.max_by(&:value)
  end

  def total_spend_current_month
    subscriptions.map(&:value).sum
  end

  def lifetime_spend
    subscriptions.map(&:total_value).sum
  end
end
