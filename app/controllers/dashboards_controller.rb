class DashboardsController < ApplicationController

  #all info we can display to the user
  def index
    #general, service_related data
    @current_user = current_user
  end

  def show
  end

  def service_stats
    #general service data
    @most_addictive_three = Service.most_addictive_three
    @most_expensive_three = Service.most_expensive_three
    @ranked_by_total_users = Service.ranked_by_total_users
    @ranked_by_total_value_of_subscriptions = Service.ranked_by_total_value_of_subscriptions
    @ranked_by_predicted_price_in_6_months = Service.ranked_by_predicted_price_in_6_months
  end

  def user_stats
    #personal, user-specific data
    if current_user.account.lifetime_spend == 0
      redirect_to none_path
    else
      @active_subscriptions = current_user.account.active_subscriptions_ordered_by_price
      @most_expensive_service = current_user.account.most_expensive_service
      @lifetime_spend = current_user.account.lifetime_spend
      @total_spend_current_month = current_user.account.total_spend_current_month
      @total_spend_by_subscription = current_user.account.total_spend_by_subscription
      @current_month = DateTime.now.month
      @current_year = DateTime.now.year
      @cancelled_services = current_user.account.cancelled_services

      #personalised predictions
      @predicted_spend_next_month = current_user.account.predicted_spending_in_x_time(DateTime.now.month + 1, DateTime.now.year)
      @predicted_spend_3_months = current_user.account.predicted_spending_in_x_time(DateTime.now.month + 2, DateTime.now.year)
      @predicted_spend_6_months = current_user.account.predicted_spending_in_x_time(DateTime.now.month + 5, DateTime.now.year)
    end
 end

 def none
 end

end
