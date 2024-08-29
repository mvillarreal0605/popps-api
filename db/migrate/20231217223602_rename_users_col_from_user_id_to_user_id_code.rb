class RenameUsersColFromUserIdToUserIdCode < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :user_id, :user_id_code
  end
end
