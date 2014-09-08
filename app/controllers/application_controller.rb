class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery 
  before_filter :set_locale
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
  def current_cart
       # cart = Cart.find(session[:cart_id])
       # puts "-------Cart----------id:"+session[:cart_id].to_s
       #   rescue ActiveRecord::RecordNotFound
       # cart = Cart.create
       # session[:cart_id] = cart.id
       # return cart

       # cart = Cart.find(session[:cart_id]) 
       if session[:cart_id].present?
          cart = Cart.find(session[:cart_id])
       else
          cart = Cart.create
          session[:cart_id] = cart.id
       end
       return cart
     end
  private 
     
end
