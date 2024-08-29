class Api::V1::PitchesController < Api::V1::BaseController
  before_action :authenticate_user!, only: [ :index, :show, :create, :update, :destroy ]
  before_action :authorize_user_session, only: [ :show, :update, :create, :destroy ]
  before_action :set_pitch, only: [ :show, :update, :destroy ]

  def index
    @pitches = Pitch.all
  end

  def show
    render status: :ok, json: @pitch
  end

  def create
    logger.info "PitchesController::create: "
    # @pitch = Pitch.new(pitch_params)
    @pitch = @session.pitches.create(pitch_params)
    if @pitch.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    logger.info "PitchesController::update: #{pitch_params}" 
    if @pitch.update(pitch_params)
      render status: :ok, json: @pitch
    else
      render_error
    end
  end

  def destroy
    @pitch.destroy
    head :no_content
  end

  private

  def set_pitch
    @pitch = Pitch.find(params[:id])
   unless @session.id == @pitch.session_id
      render json: { errors: 'Not Authorized' }, status: :unauthorized
    end
  end

  def pitch_params
    params.require(:pitch).permit(:id, :x, :y, :s, :is_strike, :sign, :session_id, :create_time, :update_time)
  end

  def render_error
    render json: { errors: @pitch.errors.full_messages },
      status: :unprocessable_entity
  end

  def authorize_user_session
    @session = Session.find(params[:session_id])
    unless @session.user_id == current_user.id
      render json: { errors: 'Not Authorized' }, status: :unauthorized
    end
  end

end
