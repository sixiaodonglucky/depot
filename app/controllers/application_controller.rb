class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale,:set_timezone
  def set_locale
	  # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
	  if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
	    session[:locale] = params[:locale]
	  end

  	  I18n.locale = session[:locale] || I18n.default_locale
  end	
  def set_timezone
      # if logged_in? && current_user.time_zone
      #   Time.zone = current_user.time_zone
      # end
  end
end
