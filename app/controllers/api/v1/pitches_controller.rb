class Api::V1::PitchesController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_pitch, only: [ :show, :update ]


  def index
    @pitches = Pitch.all
  end

  def show

  end

  def create
    @pitch = Pitch.new(pitch_params)
    if @pitch.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @pitch.update(pitch_params)
      render :show
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
  end

  def pitch_params
    params.require(:pitch).permit(:id, :pitch_time, :x, :y, :s, :is_strike, :sign, :session_id, :create_time, :update_time)
  end

  def render_error
    render json: { errors: @pitch.errors.full_messages },
      status: :unprocessable_entity
  end
end
