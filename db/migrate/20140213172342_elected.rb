class Elected < ActiveRecord::Migration
  def change
    create_table :electeds do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.string :nickname
      t.string :party
      t.integer :district
      t.integer :senate_class
      t.string :gender
      t.integer :phone_number
      t.integer :fax_number
      t.text :biography
      t.string :fec_id
      t.date :birthdate
      t.text :website
      t.string :state
    end
  end
end
