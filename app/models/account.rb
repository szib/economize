class Account < ApplicationRecord
  belongs_to :user
  has_many :subscriptions

  def active_subscriptions
    subscriptions.select(&:active?)
  end

  def cancelled_subscriptions
    subscriptions.reject(&:active?)
  end

  # data to display to user on the dashboard
  def most_expensive_service
    # services with highest monthly fees that user is currently subscribed to
    # returns hash e.g. {"Netflix"=>20.1}
    active_subscriptions_ordered_by_price.first
 end

  def lifetime_spend
    # sum of all subscriptions + corresponding months * monthly price at the time
    # errors
    total_spend = 0
    subscriptions.each do |subscription|
      subscription.billing_dates_array.each do |day|
        total_spend += subscription.service.monthly_price_on_given_day(day)
      end
    end
    total_spend.round(2)
  end

  def total_spend_current_month
    active_subscriptions_ordered_by_price.values.sum.round(2)
  end

  def total_spend_by_subscription
    # returns hash e.g. {"Netflix"=>261.3, "Amazon Prime"=>15.99, "Spotify"=>10.2}
    h = {}
    subscriptions.each do |subscription|
      total_spend = 0
      subscription.billing_dates_array.each do |day|
        total_spend += subscription.service.monthly_price_on_given_day(day)
      end
      h[subscription.service.name] = total_spend.round(2)
    end
    h.sort_by { |_k, v| v }.reverse!.to_h
 end

  def active_subscriptions_ordered_by_price
    # returns hash e.g. {"Amazon Prime"=>15.99, "Spotify"=>10.2}
    h = {}
    services_of_active_subscriptions = subscriptions.select { |subscription| subscription.end_date.nil? }.map(&:service)
    services_of_active_subscriptions.each do |service|
      h[service.name] = service.monthly_price_on_given_day(DateTime.now)
    end
    h.sort_by { |_k, v| v }.reverse!.to_h
 end

  def cancelled_services
    # returns array of names of non-active subscriptions
    services_of_non_active_subscriptions = subscriptions.reject { |subscription| subscription.end_date.nil? }.map(&:service).map(&:name)
    services_of_active_subscriptions = subscriptions.select { |subscription| subscription.end_date.nil? }.map(&:service).map(&:name)
    services_of_non_active_subscriptions.reject { |service| services_of_active_subscriptions.include?(service) }
 end

  def predicted_spending_in_x_time(month, year)
    # method input = integer >= 1 and <= 12
    total_spent = 0
    services_of_active_subscriptions = subscriptions.select { |subscription| subscription.end_date.nil? }.map(&:service)
    services_of_active_subscriptions.each do |service|
      monthly_increase = service.avg_monthly_price_increase
      current_service_price = service.price_records.sort_by(&:effective_from).map(&:monthly_price).last
      date = service.price_records.sort_by(&:effective_from).map(&:effective_from).last
      month_difference = (year * 12 + month) - (date.year * 12 + date.month)

      if !current_service_price.nil? && !monthly_increase.nil?
        total_spent += ((month_difference * monthly_increase) + current_service_price)
      else
        total_spent = total_spent
      end
    end
    total_spent
  end

  def budget_calculator; end

  # helper methods
  # private
end
