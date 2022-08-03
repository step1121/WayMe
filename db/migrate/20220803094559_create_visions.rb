class CreateVisions < ActiveRecord::Migration[6.1]
  def change
    create_table :visions do |t|
      t.integer :genre_id, null: false
      t.integer :user_id, null:false
      t.string :title, null:false
      t.text :body, null:false
      t.date :finish_on, default: -> { '(CURRENT_DATE)' }, null: false
      t.boolean :finish_status, default: false

      t.timestamps
    end
  end
end
