class AddSettingsFieldsToUserProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column :profiles, :hide_news, :boolean, default: false
  	add_column :profiles, :hide_photos, :boolean, default: false
  	add_column :profiles, :hide_user_inf, :boolean, default: false
  	add_column :profiles, :hide_anon_input, :boolean, default: false
  	add_column :profiles, :can_write, :boolean, default: true
  	add_column :profiles, :hide_all, :boolean, default: false

  end
end
