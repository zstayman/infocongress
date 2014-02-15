class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.references :committee
      t.references :elected
    end
  end
end
