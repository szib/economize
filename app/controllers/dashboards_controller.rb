class DashboardsController < ApplicationController
  # all info we can display to the user
  def index
    # general, service_related data
    @current_user = current_user
  end

  def services_stats
    # general service data
    @most_expensive_services = Service.most_expensive.first(3)
    @ranked_by_addictiveness = Service.ranked_by_addictiveness.first(3)
    @ranked_by_num_of_users = Service.ranked_by_num_of_users
    @ranked_by_value = Service.ranked_by_value
    @ranked_by_future_price = Service.ranked_by_future_price
  end

  def user_stats
    # personal, user-specific data
    authorized_for(current_user.id)
  end
end
