class Api::V1::RestaurantsController < Api::V1::BaseController
  def index
    @user_relay_registrations = UserRelayRegistration.all
  end
end
