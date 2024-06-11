class RenameSessionsPitcherIdToUserIdCode < ActiveRecord::Migration[7.0]
  def change
    rename_column :sessions, :pitcher_id, :user_id_code
  end
end
