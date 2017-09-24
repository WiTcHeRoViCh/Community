class Conversation < ApplicationRecord

	belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
 	belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

 	has_and_belongs_to_many :users
 	has_many :reports

	scope :between, -> (sender_id,recipient_id) do
 		where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
 	end

 	def last_message
 		reports.last
 	end
end
