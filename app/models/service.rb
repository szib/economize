class Service < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :service_tags
  has_many :price_records, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def oldest_price_record
    price_records.min_by(&:effective_from)
  end

  def most_recent_price_record
    price_records.max_by(&:effective_from)
  end

  def current_price
    most_recent_price_record.monthly_price
  end

  def current_price=(price)
    PriceRecord.create(
      service_id: id,
      effective_from: DateTime.now,
      monthly_price: price
    )
  end

  def total_users_lifetime
    # not unique subscriptions
    subscriptions.map(&:account_id).uniq.size
  end

  def total_active_subscriptions
    subscriptions.map(&:end_date).select(&:nil?).size
  end

  def total_spent_lifetime
    billing_dates = subscriptions.map(&:billing_dates_array).flatten!
    prices = billing_dates.map { |day| monthly_price_on_given_day(day) }.compact
    prices.sum.round(2)
 end

  # predictions
  def avg_monthly_price_increase
    first_date = price_records.sort_by(&:effective_from).map(&:effective_from).first
    final_date = price_records.sort_by(&:effective_from).map(&:effective_from).last
    monthly_difference = (final_date.year * 12 + final_date.month) - (first_date.year * 12 + first_date.month)
    first_price = price_records.sort_by(&:effective_from).map(&:monthly_price).first
    last_price = price_records.sort_by(&:effective_from).map(&:monthly_price).last
    price_difference = (last_price - first_price) / monthly_difference
    price_difference.round(2)
  end

  def avg_yearly_price_increase
    avg_monthly_price_increase * 12.round(2)
 end

  def predicted_price_in_6_months
    avg_monthly_price_increase * 6.round(2) + monthly_price_on_given_day(DateTime.now)
  end

  def predicted_price_in_3_months
    avg_monthly_price_increase * 3.round(2) + monthly_price_on_given_day(DateTime.now)
  end

  def predicted_price_in_12_years
    avg_monthly_price_increase * 12.round(2) + monthly_price_on_given_day(DateTime.now)
  end

  def self.most_addictive_three
    # service with the highest number of returning users
    # returns hash e.g. {"Spotify"=>3, "Netflix"=>1, "Amazon Prime"=>0}
    h = {}
    all.each do |service|
      account_ids = service.subscriptions.map(&:account_id)
      h[service.name] = account_ids.select { |id| account_ids.count(id) > 1 }.uniq.size
    end
    h.sort_by { |_k, v| v }.reverse!.take(3).to_h
  end

  def self.most_expensive_three
    # returns hash e.g. {"Netflix"=>20.1, "Amazon Prime"=>15.5, "Spotify"=>7.99}
    h = {}
    all.each do |service|
      h[service.name] = service.monthly_price_on_given_day(DateTime.now)
    end
    h.sort_by { |_k, v| v }.reverse!.take(3).to_h
 end

  def monthly_price_on_given_day(day) #=DateTime.new(2019,3,4))
    sorted_price_records = price_records.sort_by(&:effective_from)
    pr = sorted_price_records.select { |pr| pr.effective_from < day }.last
    if pr.nil?
      return nil
    else
      return pr.monthly_price
    end
    end
end
