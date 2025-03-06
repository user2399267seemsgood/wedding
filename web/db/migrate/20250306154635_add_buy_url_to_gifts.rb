class AddBuyUrlToGifts < ActiveRecord::Migration[5.2]
  def change
    add_column :gifts, :buy_url, :string
  end
end
