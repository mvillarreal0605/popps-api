class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :user_id
      t.text :first_name
      t.text :last_name
      t.text :nick_name
      t.text :email
      t.text :cell_number
      t.text :passwd_hash
      t.integer :pin
      t.integer :age_at_signup
      t.datetime :date_of_signup
      t.boolean :admin_flg
      t.datetime :create_time
      t.datetime :update_time

      t.timestamps
    end
  end
end
