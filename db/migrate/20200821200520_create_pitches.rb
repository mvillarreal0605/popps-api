class CreatePitches < ActiveRecord::Migration[6.0]
  def change
    create_table :pitches do |t|
      t.datetime :pitch_time
      t.integer :x
      t.integer :y
      t.integer :s
      t.boolean :is_strike
      t.text :sign
      t.integer :session_id
      t.datetime :create_time
      t.datetime :update_time

      t.timestamps
    end
  end
end
