class CreateCommittees < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.text :name
      t.text :committee_id
      t.string :chamber
      t.boolean :subcommittee
    end
  end
end
