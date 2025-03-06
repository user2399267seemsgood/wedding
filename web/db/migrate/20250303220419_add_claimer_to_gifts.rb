class AddClaimerToGifts < ActiveRecord::Migration[5.2]
  def change
    add_column :gifts, :claimer_name, :string
    add_column :gifts, :claimer_email, :string
  end
end
