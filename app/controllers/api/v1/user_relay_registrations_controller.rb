class Api::V1::UserRelayRegistrationsController < Api::V1::BaseController
  include RefreshableAuth
  require 'fmt_utl.rb'
  require 'jwt'
  
  before_action :authenticate_user!, only: [ :index, :show, :create, :update, 
                                             :unregisteruser, :unregisterrelay, :listfwd ]
  before_action :set_rrt, only: [ :show, :update, :unregisterrelay ]

  def index
    if current_user.admin_flg 
      @user_relay_registrations = UserRelayRegistration.all
      render status: :ok, json: @user_relay_registrations
    else
      render status: :unauthorized
    end
  end

  def show
    render status: :ok, json: @rrt
  end

  def create
    logger.info "...current_user.user_id_code:(#{current_user.user_id_code})"
    logger.info "...rrt_params[:user_id_code]:(#{rrt_params[:user_id_code]})"

    if (current_user.user_id_code == rrt_params[:user_id_code])
      @rrt = current_user.user_relay_registrations.create(rrt_params)
      if @rrt.valid?
        # compute RRT_JWT and return it.
        tkn = new_rrt_jwt(@rrt.user_id_code, @rrt.device_guid)
        render status: :ok, json: {jwt_rrt: tkn, status: :created}
      else
        logger.info "...@rrt creation failed."
        @rrt.errors.full_messages.each do |msg|
          logger.info "...@rrt.error: #{msg}"
        end
        render status: :internal_server_error, json: @rrt.errors
      end
    else
      logger.info "...user_id_codes do not match"
      render status: :unauthorized
    end
  end

  def update
    if @rrt.update(rrt_params)
      render status: :ok
    else
      render status: :internal_server_error, json: @rrt.errors
    end
  end

  # get relays for authenticated user....
  def listfwd
    regs = current_user.user_relay_registrations.first(params[:count].to_i) 
    render status: :ok, json: regs
  end


  # authenticated user deletes registration from another relay - sends device_guid: in body...
  #    ... user is removeing his registration from another phone ...
  #
  def unregisterrelay
    if @rrt 
      @rrt.destroy
      render status: :ok, json: {status: :deleted}
    else
      render status: :internal_server_error, json: @rrt.errors
    end
  end


  # relay dvc sends: rrt_jwt in body ... which is decoded to get device_guid.
  #     ... phone's owner is removeing another users from this phone ...
  #
  def unregisteruser
    # use RefreshableAuth::check_rrt_jwt returns {status:, user_id_code:, device_guid: }
    rrt_hsh = check_rrt_jwt(rrt_check_params[:jwt_rrt])
    @rrt = UserRelayRegistration.find_by user_id_code: rrt_hsh[:user_id_code], device_guid: rrt_hsh[:device_guid]
    @rrt.destroy
    if @rrt
      render status: :ok, json: {status: :deregistered}
    else
      render status: :internal_server_error, json: @rrt.errors
    end
  end

  def check

    # Input format: popps_body = "{device_guid: deviceUuid, rrtokens: ["jwt1" "jwt2" ...]}
    # Return format: {device_guid:dvc_guid, missing:[uidx,uidy,..,uid99]}

    relay_guid = rrt_check_params[:device_guid]
    rrts = rrt_check_params[:rrtokens]
    missing = []

    rrts.each do |rrt| 
      # decode rrt to get user_id_code
      # attempt user_relay_registrations lookup (relay_guid, user_id_code)
      # if Failed, add user_id_code to missing[]
      rrt_hsh = check_rrt_jwt(rrt)    # use RefreshableAuth::check_rrt_jwt returns {status:, user_id_code:, device_guid: }
      if rrt_hsh[:status] == false    # return invalid rrt-s for removal from reg list.
        missing.append( [rrt] )
      else
        logger.info "...Find_by_....user_id_code:#{rrt_hsh[:user_id_code]} and DeviceGuid:#{rrt_hsh[:device_guid]}"
        xrrt = UserRelayRegistration.find_by user_id_code: rrt_hsh[:user_id_code], device_guid: rrt_hsh[:device_guid]
        if !xrrt     # lookup failed"
          missing.append( [rrt] )
        end
      end
    end
    render status: :ok, json: { device_guid: rrt_check_params[:device_guid], missing: missing}
  end


  private

  def set_rrt
    @rrt = UserRelayRegistration.find_by user_id_code: current_user.user_id_code, device_guid: rrt_params[:device_guid]
  end

  def rrt_params
    params.require(:user_relay_registration).permit(:id, :user_id_code,
          :device_guid, :device_description, :usage_count)
  end

 def rrt_check_params
   # params.require(:user_relay_registration).permit(:device_guid, :rrtokens )
   # Note: .permit(... :rrtokens) returns an error - appears to test for defined fields ??
   params.require(:user_relay_registration)
  end

end
