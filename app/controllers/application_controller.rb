class ApplicationController < ActionController::Base
protect_from_forgery #追記
before_action :authenticate_user!, except: [:top, :about, :sign_in, :sign_up]

before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected


  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email]) # 注目
  end
end
