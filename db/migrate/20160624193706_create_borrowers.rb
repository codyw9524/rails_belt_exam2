class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :reason
      t.text :description
      t.float :amount_needed
      t.float :amount_received
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
