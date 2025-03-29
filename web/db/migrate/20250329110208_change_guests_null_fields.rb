class ChangeGuestsNullFields < ActiveRecord::Migration[7.2]
  def change
    change_column_null :guests, :email, true
    change_column_null :guests, :first_name, false
    change_column_null :guests, :last_name, false
  end
end
