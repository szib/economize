class SubscriptionsController < ApplicationController
  before_action :find_subscription, except: %i[index new create]

  def index
    @subscriptions = current_user.active_subscriptions
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
      flash[:success] = 'Subscription successfully created'
      redirect_to subscriptions_path
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @subscription.update_attributes(subscription_params)
      flash[:success] = 'Subscription was successfully updated'
      redirect_to @subscription
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def cancel
    @subscription = Subscription.find(params[:id])
    @subscription.end_date = DateTime.now
    @subscription.save
    flash[:success] = 'Subscription cancelled'
    redirect_to subscriptions_path
  end

  def destroy
    @subscription = Subscription.find(params[:id]).destroy
    #  @article.destroy
    if @subscription.destroy
      flash[:success] = 'Subscription was successfully deleted'
      redirect_to subscriptions_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to subscriptions_path
    end
  end

  private

  def find_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:service_id)
  end
end
