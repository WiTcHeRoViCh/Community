class AddInfoFieldsToUserProfile < ActiveRecord::Migration[5.1]
  def change
  	add_column :profiles, :hobby, :string
  	add_column :profiles, :favorite_music, :string
  	add_column :profiles, :position, :string
  	add_column :profiles, :plan_for_future, :string
  	add_column :profiles, :description, :string
  	add_column :profiles, :association_with_animal, :string
  	add_column :profiles, :country, :string
  	add_column :profiles, :place_of_study, :string
  	add_column :profiles, :where_want_to_live, :string
  end
end
