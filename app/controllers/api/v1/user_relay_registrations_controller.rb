class Api::V1::UserRelayRegistrationsController < Api::V1::BaseController
  before_action :set_urr, only: [ :show, :update ]


  def index
    @user_relay_registrations = UserRelayRegistration.all
  end

  def show

  end

  def create
    @urr = UserRelayRegistration.new(urr_params)
    if @urr.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @urr.update(urr_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @urr.destroy
    head :no_content
  end

  private

  def set_urr
    @urr = UserRelayRegistration.find(params[:id])
  end

  def urr_params
    params.require(:user_relay_registration).permit(:id, :user_id, :device_guid, :device_description, :usage_count, :create_time, :update_time)
  end

  def render_error
    render json: { errors: @urr.errors.full_messages },
      status: :unprocessable_entity
  end
end
