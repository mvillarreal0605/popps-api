class RemovePitchTimeFromPitches < ActiveRecord::Migration[7.0]
  def change
    remove_column :pitches, :pitch_time, :datetime
  end
end
