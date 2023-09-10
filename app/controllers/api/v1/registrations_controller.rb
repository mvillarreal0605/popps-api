class Api::V1::RegistrationsController < Devise::RegistrationsController
  include RackSessionsFix

  respond_to :json

   before_action :ensure_params_exist, only: :create
   protect_from_forgery with: :null_session
   skip_before_action :verify_authenticity_token, :only => :create
 
  private

# def sign_up_params
#       params.require(:user).permit(
#         :user_id, :password, :password_confirmation, :nick_name, :last_name,
#         :first_name, :email, :cell_number, :admin_flg, :pin)
#   end
   
   def ensure_params_exist
       return if params[:user].present?
       render json: {
           messages: "Missing Params",
           is_success: false,
           data: {}
         }, status: :bad_request
   end

  # ...called at end of Devise::RegistrationController create() ...
  def respond_with(current_user, _opts = {})

    if resource.persisted?
      render json: {
        status: {code: 200, message: 'Signed up successfully.'},
        data: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
      }, status: :unprocessable_entity
    end
  end

end

