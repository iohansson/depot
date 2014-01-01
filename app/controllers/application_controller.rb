class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_i18n_locale_from_params
  before_filter :authorize
  
  protected
  
    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
    
    def default_url_options
      { locale: I18n.locale }
    end
  
    def authorize
      unless request.format == Mime::HTML
        authenticate_or_request_with_http_basic do |name,password|
          user = User.find_by_name(name)
          if user && user.authenticate(password)
            session[:user_id] = user.id
          end
        end
      else
        unless User.find_by_id(session[:user_id])
          redirect_to login_url, notice: 'Please log in'
        end
      end
    end
end
