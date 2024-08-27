class RemoveUpdateTimeFromSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :sessions, :update_time, :datetime
  end
end
