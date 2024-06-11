class Api::V1::SessionsController < Api::V1::BaseController

  # respond_to :json

  # logger.info "...sessions - call authenticate_user!."
  before_action :authenticate_user!, only: [ :index, :show, :create, :listfwd, :update, :destroy ]
  before_action :set_session, only: [ :show, :update, :destroy ]

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

  def update
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
                                    :description, :current_session, :start_time, :user_id_code, 
                                    :create_time, :update_time, :last_date, :count)
  end

  def render_error
    render json: { errors: @session.errors.full_messages },
      status: :unprocessable_entity
  end
end
