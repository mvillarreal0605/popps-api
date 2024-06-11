class AddDefaultDateTimeToUsersDateOfSignup < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :date_of_signup, -> { 'CURRENT_TIMESTAMP' }
  end
end
