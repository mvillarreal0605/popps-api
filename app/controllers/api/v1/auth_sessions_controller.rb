class Api::V1::AuthSessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session
  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create

  # sign in
  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in "user", @user
      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        data: {user: @user}
      }, status: :ok
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  private
  def sign_in_params
    params.require(:sign_in).permit :user_id, :password
  end

  def load_user
    @user = User.find_for_database_authentication(user_id: sign_in_params[:user_id])
    if @user
      return @user
    else
      render json: {
        messages: "Cannot get User",
        is_success: false,
        data: {}
      }, status: :failure
    end
  end
end
