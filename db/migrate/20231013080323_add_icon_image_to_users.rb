class AddIconImageToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :icon_image, :string
  end
end
