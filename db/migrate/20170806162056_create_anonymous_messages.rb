class CreateAnonymousMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :anonymous_messages do |t|
      t.string :body
      t.integer :user_id

      t.timestamps
    end
  end
end
