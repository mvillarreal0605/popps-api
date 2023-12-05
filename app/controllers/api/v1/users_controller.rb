class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user!, only: [ :index, :show, :update, :destroy ]
  before_action :set_user, only: [ :index, :show, :update, :destroy ]

  logger.info "UsersController"

  def index
    if @user.admin_flg 
      @users = User.all
    end
  end

  def show
    logger.info "... show: current_user: #{current_user}"
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @user.update(user_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def validatepin
    @user = User.find_by(user_id: user_params[:user_id])
    if (@user && (@user.pin.to_s == user_params[:pin] ))
        render json: {pin: true}
    else
      render json: {pin: false}
    end
  end


  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :user_id, :first_name, :last_name, :nick_name, :email, :cell_number, :passwd_hash, :pin, :age_at_signup, :date_of_signup, :admin_flg, :create_time, :update_time)
  end

  def render_error
    render json: { errors: @user.errors.full_messages },
      status: :unprocessable_entity
  end
end
