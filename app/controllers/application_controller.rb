class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    logger.info "ApplicationController with devise request."
    logger.info "...params: #{params.inspect}"

    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :nick_name, 
         :first_name, :email, :cell_number,
         :admin_flg, :pin])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:user_id, :password, 
                                      :relay_id, :jwt_rrt])

    devise_parameter_sanitizer.permit(:account_update, keys: [:user_id, :last_name,
          :nick_name, :first_name, :email, :cell_number, :admin_flg, :pin])
  end

end
