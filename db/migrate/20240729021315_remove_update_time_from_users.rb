class RemoveUpdateTimeFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :update_time, :datetime
  end
end
