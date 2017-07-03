class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|

    	t.string :name
    	t.string :surname
    	t.integer :age
    	t.string :post
    	t.string :avatar
    	t.date :birthday
    	t.integer :user_id

      t.timestamps
    end
  end
end
