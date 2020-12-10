class CreateInquiries < ActiveRecord::Migration[6.0]
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :phone_number
      t.string :email
      t.string :organization

      t.timestamps
    end
  end
end
