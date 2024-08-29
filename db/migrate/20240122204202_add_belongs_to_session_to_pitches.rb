class AddBelongsToSessionToPitches < ActiveRecord::Migration[7.0]
  def change
    remove_column :pitches, :session_id, :integer
    add_reference :pitches, :session
  end
end
