class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.json :images
      t.integer :user_id

      t.timestamps
    end
  end
end
