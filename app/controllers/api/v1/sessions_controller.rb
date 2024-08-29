class Api::V1::SessionsController < Api::V1::BaseController

  # respond_to :json

  # logger.info "...sessions - call authenticate_user!."
  before_action :authenticate_user!, only: [ :index, :show, :create, :listfwd, :pitches, :update, :destroy ]
  before_action :set_session, only: [ :show, :update, :destroy, :pitchlist ]
  before_action :authorize_user, only: [ :show, :update, :destroy, :pitchlist ]
 
  logger.info "...sessions - Startup."
 
  def index
    @sessions = Session.all
  end

  def show
    render status: :ok, json: @session
  end

  def create
    logger.info "...sessions - create method for user #{current_user}."
    @session = current_user.sessions.create(session_params)
    logger.info "...sessions - create @session."
    if @session.save
      logger.info "...sessions - created #{@session}."
      render status: :ok, json: @session
    else
      logger.info "...sessions - save failed: #{@session.errors.full_messages }"
      render_error
    end
  end

  def destroy
    @session.destroy
    head :no_content
  end

  def listfwd
    logger.info "...sessions - listfwd method for user #{current_user.last_name}."
    logger.info "...sessions - listfwd with last_date: #{params[:last_date]} and count: #{params[:count]}" 
    # this should be start_time instead of created_at ....
    @sessions = current_user.sessions.where("created_at < ?", params[:last_date]).limit(params[:count])
    render status: :ok, json: @sessions
  end

  def pitchlist
    logger.info "...sessions - pitchlist method for user #{current_user.last_name}."
    @pitchlist = @session.pitches
    render status: :ok, json: {session:  @session, pitches:  @session.pitches}
  end

  def update
    logger.info "SessionsController::update: #{session_params}" 
    if @session.update(session_params)
      render status: :ok, json: @session
    else
      render_error
    end
  end


  private

  def set_session
    @session = Session.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:id, :relay_device_guid, :relay_description, :pitch_analyzer,
                                    :description, :current_session, :user_id_code, :created_at,
                                    :updated_at )
  end

  def authorize_user
    unless @session.user_id == current_user.id
      render json: { errors: 'Not Authorized' }, status: :unauthorized
    end
  end

  def render_error
    render json: { errors: @session.errors.full_messages },
      status: :unprocessable_entity
  end
end
