class Api::V1::SessionsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_session, only: [ :show, :update ]


  def index
    @sessions = Session.all
  end

  def show

  end

  def create
    @session = Session.new(session_params)
    if @session.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @session.update(session_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @session.destroy
    head :no_content
  end

  private

  def set_session
    @session = Session.find(params[:id])
  end

  def session_params
    params.require(:session).permit(:id, :relay_device_guid, :relay_description, :pitch_analyzer, :description, :current_session, :start_time, :pitcher_id, :create_time, :update_time)
  end

  def render_error
    render json: { errors: @session.errors.full_messages },
      status: :unprocessable_entity
  end
end
