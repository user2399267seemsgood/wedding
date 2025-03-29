class ChangeGuestsEmailNullable < ActiveRecord::Migration[7.2]
  def change
    change_column_null :guests, :email, true
  end
end
