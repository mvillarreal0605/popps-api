class RemoveStartTimeFromSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :sessions, :start_time, :datetime
  end
end
