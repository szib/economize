class Account < ApplicationRecord
  belongs_to :user
  has_many :subscriptions

  validates :user_id, presence: true

  #display to user on the dashboard
  def total_spend_for_current_month
  end

  def total_spend_by_month
  end

  def total_spend_by_subscription
  end

  def subscriptions_ordered_by_price
  end

  def predicted_spending_in_6_months
  end

  def predicted_annual_spend
  end

  def within_budget?
  end

  def budget_details
  end





end
