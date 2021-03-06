class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :is_user_allowed?, except: :login

  include ApplicationHelper

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def is_user_allowed?
    if !current_user.nil?
      unless is_current_user_admin?
        #raise "Unauthorized User"
        sign_out current_user
        flash[:notice] = "Sie sind nicht authorisiert!"
        redirect_to new_user_session_path
      end
    end
  end

end
