class DashboardsController < ApplicationController

  #all info we can display to the user
  def index
    #general, service_related data
    @most_addictive_three = Service.most_addictive_three
    @most_expensive_three = Service.most_expensive_three
  end

  def show
    #personal, user-specific data
    @active_subscriptions = current_user.account.active_subscriptions_ordered_by_price
    @most_expensive_service = current_user.account.most_expensive_service
    @lifetime_spend = current_user.account.lifetime_spend
    @total_spend_current_month = current_user.account.total_spend_current_month
    @total_spend_by_subscription = current_user.account.total_spend_by_subscription
    @current_month = DateTime.now.month
    @current_year = DateTime.now.year
    @cancelled_services = current_user.account.cancelled_services

    #predictions
    @predicted_spend_next_month = current_user.account.predicted_spending_in_x_time(DateTime.now.month + 1.month, DateTime.now.year)
    @predicted_spend_3_months = current_user.account.predicted_spending_in_x_time(DateTime.now.month + 2.months, DateTime.now.year)
    @predicted_spend_6_months = current_user.account.predicted_spending_in_x_time(DateTime.now.month + 5.months, DateTime.now.year)


    @most_addictive_three = Service.most_addictive_three
    @most_expensive_three = Service.most_expensive_three
  end


end
