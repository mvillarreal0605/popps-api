class Api::V1::AuthSessionsController < Devise::SessionsController
  include RackSessionsFix
  include RefreshableAuth
  require 'jwt'

  respond_to :json

  protect_from_forgery with: :null_session

  logger.info "Auth_sessions_controller"
 
  # sign in
  def create
    logger.info "login: create() - params: #{params}"
    logger.info "... - params[:auth_session]: #{params[:auth_session]}"
    if params[:user][:jwt_rrt]
     logger.info "...user.jwt_rrt: #{params[:user][:jwt_rrt]}"
     current_user = User.find_by user_id_code: params[:user][:user_id_code]

      # Hash contents: {status: jwt_status, user_id_code: user_id_code, device_guid: device_guid}
      chk_hsh = check_rrt_jwt(params[:user][:jwt_rrt])
      logger.info "...chk_hsh: #{chk_hsh}"
      if (current_user == nil) || (chk_hsh[:status] == false)
        respond_with_error()
      else
        if current_user.user_id_code == chk_hsh[:user_id_code] && params[:user][:relay_id] == chk_hsh[:device_guid]
          logger.info "...check the user_relay_registration entry..."
          rrt = UserRelayRegistration.find_by user_id_code: chk_hsh[:user_id_code], device_guid: chk_hsh[:device_guid]
          if rrt != nil
            logger.info "...do the jwt_rrt login..."
            sign_in(:user, current_user)
            respond_with(current_user)
          else
            respond_with_error()
          end
        else
          respond_with_error()
        end
      end

    else   #..convetional user_id_code & pwd login....
      super
    end
  end


  private

  def respond_with_error
    render json: {
      status: { 
        code: 401, message: 'Invalid credentials.',
      }
    }, status: 401
  end

  def respond_with(current_user, _opts = {})
    render json: {
      status: { 
        code: 200, message: 'Login  successfull.',
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if request.headers['Authorization'].present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
      current_user = User.find(jwt_payload['sub'])
    end
    
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end


  def decrypt text
    salt, data = text.split "$$"

    len   = ActiveSupport::MessageEncryptor.key_len
    key   = ActiveSupport::KeyGenerator.new(
            Rails.application.secrets.secret_key_base).generate_key salt, len
    crypt = ActiveSupport::MessageEncryptor.new key
    crypt.decrypt_and_verify data
  end

end
