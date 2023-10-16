class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :user_id
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
