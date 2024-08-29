class RenameUserIdToUserIdCodeInUserRelayRegistrations < ActiveRecord::Migration[7.0]
  def change
    remove_index  :user_relay_registrations, name: "index_user_relay_registrations_on_user_id_and_device_guid"
    rename_column :user_relay_registrations, :user_id, :user_id_code
    add_index :user_relay_registrations, [:user_id_code, :device_guid], unique: true
  end
end
