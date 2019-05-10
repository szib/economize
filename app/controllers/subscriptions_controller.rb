class SubscriptionsController < ApplicationController
  before_action :find_subscription, except: %i[index new create archive]
  before_action :find_user

  def index
    @subscriptions = @user.active_subscriptions
  end

  def archive
    @subscriptions = @user.cancelled_subscriptions
  end

  def show; end

  def new
    @subscription = Subscription.new
  end

  def edit; end

  def create
    @account = current_user.account
    @subscription = Subscription.new(subscription_params)
    @subscription.start_date = DateTime.now
    @subscription.account_id = current_user.account.id

    if @subscription.save
      flash[:success] = "You successfully subscribed for #{@subscription.service_name}."
      redirect_to user_subscriptions_path
    else
      flash[:error] = 'You have already subscribed to this service.'
      render 'new'
    end
  end

  def cancel
    @subscription = Subscription.find(params[:id])
    @subscription.end_date = DateTime.now

    if @subscription.save
      flash[:success] = "Your subscription to #{@subscription.service_name} has been cancelled."
      redirect_to user_subscriptions_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to user_subscriptions_path
    end
  end

  private

  def find_subscription
    @subscription = Subscription.find(params[:id])
  end

  def find_user
    authorized_for(params[:user_id])
    @user = current_user
  end

  def subscription_params
    params.require(:subscription).permit(:service_id)
  end
end
