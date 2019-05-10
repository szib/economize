module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    @current_user ||= User.new
  end

  def authorized?
    unless logged_in?
      flash[:error] = "You're not logged in."
      redirect_to(signin_path) && return
    end
  end

  def authorized_for(user_id)
    if current_user.id != user_id.to_i
      flash[:error] = "You're not allowed to view this page."
      redirect_to(root_path) && return
    end
  end

  def logged_in?
    !!current_user.id
  end
end
