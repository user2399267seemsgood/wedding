class RenameBuyUrLtoPurchaseLink < ActiveRecord::Migration[5.2]
  def change
    rename_column :gifts, :buy_url, :purchase_link
  end
end
