class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.references :user, null: false
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
