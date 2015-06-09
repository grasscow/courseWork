class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user, :log


  private



  def set_current_user
    @current_user=User.find(session[:user_id]) if session[:user_id].present?
  end

  def log

    return if @current_user.present? && @current_user.try(:admin?)

    Log.create(user: @current_user, session_id: session[:session_id], uri: request.fullpath, params: params.to_json)
  end

  def check_authentication
    unless @current_user
      flash[:danger]="Доступ без авторизации запрещен"
      redirect_to login_path
    end
  end

  def admin_permission
    unless @current_user.try(:admin?)
      flash[:danger]="Недостаточно прав для просмотра страницы"
      redirect_to root_path
    end
  end
  
  def render_error(msg="Доступ запрещен")
    flash[:danger]=msg
    redirect_to root_path
  end


end
