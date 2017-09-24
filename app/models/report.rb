class Report < ApplicationRecord

	belongs_to :conversation
	belongs_to :sender, foreign_key: 'user_id', class_name: 'User'

end
