class AddBelongsToUserToUserRelayRegistrations < ActiveRecord::Migration[7.0]
  def change
   add_reference :user_relay_registrations, :user 
  end
end
