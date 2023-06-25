class Api::V1::RegistrationsController < Devise::RegistrationsController
    before_action :ensure_params_exist, only: :create
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token, :only => :create


    # sign up
    def create
      logger.info "RegistrationsController::create() user_params: #{user_params.inspect}"
      user = User.new user_params

      if user.save
        render json: {
          messages: "Sign Up Successfully",
          is_success: true,
          data: {user: user}
        }, status: :ok
      else
        logger.info "....user: #{user.errors.inspect}"
        render json: {
          messages: "Sign Up Failded",
          is_success: false,
          data: {}
        }, status: :unprocessable_entity
      end
    end
  
    private
    def user_params
      params.require(:user).permit(
        :user_id, :password, :password_confirmation, :nick_name, :last_name,
        :first_name, :email, :cell_number, :admin_flg, :pin)
    end
  
    def ensure_params_exist
      return if params[:user].present?
      render json: {
          messages: "Missing Params",
          is_success: false,
          data: {}
        }, status: :bad_request
    end
  end

