class CreateElectedsUsers < ActiveRecord::Migration
  def change
    create_table :electeds_users do |t|
      t.references :elected
      t.references :user
    end
  end
end
