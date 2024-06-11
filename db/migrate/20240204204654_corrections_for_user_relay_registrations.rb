class CorrectionsForUserRelayRegistrations < ActiveRecord::Migration[7.0]
  def change 
    remove_column :user_relay_registrations, :create_time, :datetime
    remove_column :user_relay_registrations, :update_time, :datetime
    change_column_default :user_relay_registrations, :usage_count, 1
  end
end
