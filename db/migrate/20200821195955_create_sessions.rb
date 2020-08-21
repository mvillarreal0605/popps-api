class CreateSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :sessions do |t|
      t.text :relay_device_guid
      t.text :relay_description
      t.text :pitch_analyzer
      t.text :description
      t.boolean :current_session
      t.datetime :start_time
      t.text :pitcher_id
      t.datetime :create_time
      t.datetime :update_time

      t.timestamps
    end
  end
end
