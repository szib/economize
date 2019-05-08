
class Subscription < ApplicationRecord
  belongs_to :account
  belongs_to :service

  validates :start_date, presence: true
  validates :account_id, presence: true
  validates :service_id, presence: true
  validate :user_has_no_active_subscrpition

 def user_has_no_active_subscrpition
   account = Account.find(account_id)
   subscription = account.subscriptions.find_by(service_id: service_id)

   errors.add(:base, 'Already subscribed.') if subscription&.active?
 end

  def active?
    self.end_date.nil?
  end

  def subscription_length_in_months
    start_date = self.start_date
    if self.end_date != nil
        end_date = self.end_date
    else
        end_date = DateTime.now
    end

    length_in_days = (end_date.to_i-start_date.to_i)/(3600*24)
    if length_in_days%30 == 0 || length_in_days==365||366
      length_in_months = length_in_days/30
    else
      length_in_months = (length_in_days/30)+1
    end
  end

  def billing_dates_array
    start_date = self.start_date
    billing_dates = []
    billing_dates << start_date
    (subscription_length_in_months).times do
      billing_dates << billing_dates.last + 1.month
    end
    return billing_dates
 end

end
