class CreateUserRelayRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :user_relay_registrations do |t|
      t.text :user_id
      t.text :device_guid
      t.text :device_description
      t.integer :usage_count
      t.datetime :create_time
      t.datetime :update_time

      t.timestamps
    end
  end
end
