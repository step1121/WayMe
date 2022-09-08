class CreateVisionComments < ActiveRecord::Migration[6.1]
  def change
    create_table :vision_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :vision_id

      t.timestamps
    end
  end
end
