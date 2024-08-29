class RemoveCreateTimeFromSessions < ActiveRecord::Migration[7.0]
  def change
    remove_column :sessions, :create_time, :datetime
  end
end
