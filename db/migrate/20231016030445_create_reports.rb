class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.bigint :user_id, null: false
      t.string :title
      t.string :body
      t.timestamps
    end

    add_foreign_key :reports, :users, column: :user_id
    add_index :reports, :user_id
  end
end
