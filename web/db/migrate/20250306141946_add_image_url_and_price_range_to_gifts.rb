class AddImageUrlAndPriceRangeToGifts < ActiveRecord::Migration[5.2]
  def change
    add_column :gifts, :image_url, :string
    add_column :gifts, :price_range, :string
  end
end
