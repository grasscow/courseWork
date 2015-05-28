class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references :user, index: true, foreign_key: true
      t.string :session_id, index: true
      t.string :uri, length: 2048, null: false, index: true
      t.text :params

      t.timestamps null: false
    end
  end
end
