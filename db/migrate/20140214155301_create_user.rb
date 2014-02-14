class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :zip
      t.string :password_digest
      t.string :email
    end
  end
end
