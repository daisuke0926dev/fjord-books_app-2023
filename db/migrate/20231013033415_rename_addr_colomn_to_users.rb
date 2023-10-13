class RenameAddrColomnToUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :addr, :address
  end
end
