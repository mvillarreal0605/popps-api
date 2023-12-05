class Api::V1::UserRelayRegistrationsController < Api::V1::BaseController
  include RefreshableAuth
  require 'fmt_utl.rb'
  require 'jwt'
  before_action :authenticate_user!, only: [ :index, :show, :create, :update, :deletebykey ]
  before_action :set_rrt, only: [ :show, :update, :deletebykey ]



  def index
    if current_user.admin_flg 
      @user_relay_registrations = UserRelayRegistration.all
      render json: @user_relay_registrations
    end
  end

  def show
    render json: @rrt
  end

  def create

    @rrt = UserRelayRegistration.new(rrt_params)
    logger.info "...current_user.user_id:(#{current_user.user_id})"
    logger.info "...@rrt.user_id:(#{@rrt.user_id})"

    if (current_user.user_id == @rrt.user_id)
      if @rrt.save
        # compute RRT_JWT and return it.
        tkn = new_rrt_jwt  @rrt.user_id, @rrt.device_guid 
        render json: {jwt_rrt: tkn, status: :created}
        # render :show, status: :created
      else
        logger.info "...@rrt.save is false"
        @rrt.errors.full_messages.each do |msg|
          logger.info "...@rrt.error: #{msg}"
        end
        render_error POPPS::InvalidState
      end
    else
      logger.info "...user_ids do not match"
      render_error POPPS::InvalidCredentials
    end
  end

  def update
    if @rrt.update(rrt_params)
      render :show
    else
      render_error POPPS::ServerError
    end
  end

  # authenticated user sends device_guid: in body...
  def deletebykey
    if @rrt 
      @rrt.destroy
      render json: {status: :deleted}
    else
      render_error POPPS::ServerError
    end
  end

  # relay dvc sends: rrt_jwt in body...
  def deregister
    # use RefreshableAuth::check_rrt_jwt returns {status:, user_id:, device_guid: }
    rrt_hsh = check_rrt_jwt(rrt_check_params[:jwt_rrt])
    @rrt = UserRelayRegistration.find_by user_id: rrt_hsh[:user_id], device_guid: rrt_hsh[:device_guid]
    @rrt.destroy
    if @rrt
      render json: {status: :deregistered}
    else
      render_error POPPS::ServerError
    end
  end

  def check

    # Input format: popps_body = "{device_guid: deviceUuid, rrtokens: ["jwt1" "jwt2" ...]}
    # Return format: {device_guid:dvc_guid, missing:[uidx,uidy,..,uid99]}

    relay_guid = rrt_check_params[:device_guid]
    rrts = rrt_check_params[:rrtokens]
    missing = []

    rrts.each do |rrt| 
      # decode rrt to get user_id
      # attempt user_relay_registrations lookup (relay_guid, user_id)
      # if Failed, add user_id to missing[]
      rrt_hsh = check_rrt_jwt(rrt)    # use RefreshableAuth::check_rrt_jwt returns {status:, user_id:, device_guid: }
      if rrt_hsh[:status] == false    # return invalid rrt-s for removal from reg list.
        missing.append( [rrt] )
      else
        xrrt = UserRelayRegistration.find_by_user_id_and_device_guid(rrt_hsh[:user_id], rrt_hsh[:device_guid])
        if !xrrt     # lookup failed"
          missing.append( [rrt] )
        end
      end
    end
    render json: { device_guid: rrt_check_params[:device_guid], missing: missing}
  end


  private

  def set_rrt
    @rrt = UserRelayRegistration.find_by_user_id_and_device_guid(current_user.user_id, rrt_params[:device_guid])
  end

  def rrt_params
    params.require(:user_relay_registration).permit(:id, :user_id,
          :device_guid, :device_description, :usage_count)
  end

 def rrt_check_params
   # params.require(:user_relay_registration).permit(:device_guid, :rrtokens )
   # Note: .permit(... :rrtokens) returns an error - appears to test for defined fields ??
   params.require(:user_relay_registration)
  end

  def render_error(err_defn)
    render json: { errors:  FmtUtl.err_compose( err_defn, @rrt.errors.full_messages.to_s) },
      status: POPPS::HTTP_InternalServerError
  end

end
