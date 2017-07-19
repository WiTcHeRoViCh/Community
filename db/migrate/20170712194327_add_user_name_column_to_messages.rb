class AddUserNameColumnToMessages < ActiveRecord::Migration[5.1]
  def change
  	add_column :messages, :user_name, :string
  end
end
