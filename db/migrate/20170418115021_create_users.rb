class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
    	t.string :code
    	t.string :name
    	t.string :surname
    	t.integer :age
    	t.string :post
    	t.string :password_digest

      t.timestamps
    end
  end
end
