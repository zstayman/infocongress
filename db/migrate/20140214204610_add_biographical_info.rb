class AddBiographicalInfo < ActiveRecord::Migration
  def change
    add_column :electeds, :bio_text, :text
  end
end
