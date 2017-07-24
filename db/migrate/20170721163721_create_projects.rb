class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
    	t.integer :user_id
      t.string :title
      t.string :photo
      t.string :description
      t.boolean :approved, default: false
      t.string :user_code
      t.string :crew

      t.timestamps
    end
  end
end
