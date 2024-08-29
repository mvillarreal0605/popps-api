class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user!, only: [ :index, :show, :update, :destroy ]
  before_action :set_user, only: [ :index, :show, :update, :destroy ]

  logger.info "UsersController"

  def index
    if @user.admin_flg 
      render  status: :ok, json: User.all
    end
  end

  def show
    logger.info "... show: current_user: #{@user}"
    render status: :ok, json: @user 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render status: :created, json: @user
    else
      render status: :internal_server_error, json: {error: @user.errors}
    end
  end

  def update
    logger.info "... update: current_user: #{@user}"
    logger.info "... user_params: #{user_params}"
    if @user.update(user_params)
      logger.info "...update OK - now render :status"
      render status: :ok, json: {data: 'POST User Information Updated'}
    else
      logger.info "...errors: #{@user.errors}"
      render status: :internal_server_error, json: {error: @user.errors}
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  def validatepin
    @user = User.find_by(user_id_code: user_params[:user_id_code])
    if (@user && (@user.pin.to_s == user_params[:pin] ))
      render status: :ok, json: {pin: true}
    elsif @user
      render  status: :ok, json: {pin: false}
    else
      render status: :not_found
    end
  end


  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:id, :user_id_code, :first_name, :last_name,
          :nick_name, :email, :cell_number, :passwd_hash, :pin, 
          :age_at_signup, :date_of_signup, :admin_flg, :create_time, :update_time)
  end

end
