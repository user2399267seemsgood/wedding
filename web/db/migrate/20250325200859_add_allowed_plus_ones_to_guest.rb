class AddAllowedPlusOnesToGuest < ActiveRecord::Migration[7.2]
  def change
    add_column :guests, :allowed_plus_ones, :integer
  end
end
