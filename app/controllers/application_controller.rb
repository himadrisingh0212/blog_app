class ApplicationController < ActionController::Base
  before_action :authenticate_user! , unless: :devise_controller?
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action:configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:avatar])
    devise_parameter_sanitizer.permit(:account_update,keys:[:avatar])
  end
  allow_browser versions: :modern


  #def authenticate_user!
   # unless session[:user_id]
    #  redirect_to "/login", alert: "You must login first"
    #end
  #end


  #for using auth.html.erb
  layout :layout_by_resource
   def layout_by_resource
   if devise_controller?
      "auth"   # use new theme for login/signup
    else
      "application"  # normal theme
    end
  end


  def after_sign_in_path_for(resource)
    # Must go to a page that does NOT redirect back to login
   posts_path # or authenticated_root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path  # send to login page
  end

  
  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
end
