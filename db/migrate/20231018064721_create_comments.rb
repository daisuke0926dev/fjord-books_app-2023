class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.bigint :user_id, null: false
      t.text :content
      t.references :commentable, polymorphic: true, null: false
      t.timestamps
    end

    add_foreign_key :comments, :users, column: :user_id
    add_index :comments, :user_id
  end
end
