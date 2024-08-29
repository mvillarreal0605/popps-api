class RemoveCreateTimeFromPitches < ActiveRecord::Migration[7.0]
  def change
    remove_column :pitches, :create_time, :datetime
  end
end
