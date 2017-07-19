class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
    	t.string :title
    	t.string :photo
    	t.text :description
    	t.string :importance
    	t.string :user_code

      t.timestamps
    end
  end
end
