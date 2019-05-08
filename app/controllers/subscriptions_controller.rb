class SubscriptionsController < ApplicationController
  before_action :find_subscription, except: %i[index new create]

  def index
    @subscriptions = current_user.account.subscriptions
  end

  def show; end

  def new
    @subscription = Subscription.new
  end

  def edit; end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      flash[:success] = 'Subscription successfully created'
      redirect_to @subscription
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @subscription.update_attributes(params[:subscription])
      flash[:success] = 'Subscription was successfully updated'
      redirect_to @subscription
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @subscription.destroy
      flash[:success] = 'Subscription was successfully deleted'
      redirect_to @subscriptions_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to @subscriptions_path
    end
  end

  private

  def find_subscription
    @subscription = Subscription.find(params[:id])
  end
end
