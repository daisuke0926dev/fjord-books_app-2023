class AddStringColToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :post_code, :string
    add_column :users, :addr, :string
    add_column :users, :biography, :string
  end
end
