class RemoveUpdateeTimeFromPitches < ActiveRecord::Migration[7.0]
  def change
    remove_column :pitches, :update_time, :datetime
  end
end
