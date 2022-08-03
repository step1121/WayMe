class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :vision_id, null: false
      t.string :content, null:false
      t.date :completion_on, default: -> { '(CURRENT_DATE)' }, null: false
      t.boolean :completion_status, default: false

      t.timestamps
    end
  end
end
