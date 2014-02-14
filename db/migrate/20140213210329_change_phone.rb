class ChangePhone < ActiveRecord::Migration
  def change
    change_column(:electeds, :phone_number, :string)

  end
end
