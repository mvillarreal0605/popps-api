class AddUsrDvcIndexToUserRelayRegistrations < ActiveRecord::Migration[7.0]
  def change
    add_index :user_relay_registrations, [:user_id, :device_guid], unique: true
  end
end
