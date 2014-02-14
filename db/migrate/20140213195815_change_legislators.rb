class ChangeLegislators < ActiveRecord::Migration
  def change
    rename_column(:electeds, :title, :house)
  end
end
