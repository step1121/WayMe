class CreateFights < ActiveRecord::Migration[6.1]
  def change
    create_table :fights do |t|
      t.integer :user_id
      t.integer :vision_id

      t.timestamps
    end
  end
end
