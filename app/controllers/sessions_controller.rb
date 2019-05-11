class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    authenticated = user.try(:authenticate, params[:session][:password])
    if authenticated
      log_in user
      redirect_to dashboard_path
    else
      flash[:negative] = 'Invalid email or password. Try again.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
