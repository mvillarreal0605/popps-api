class AddBelongsToUserToSessions < ActiveRecord::Migration[7.0]
  def change
   add_reference :sessions, :user 
  end
end
