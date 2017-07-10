class Message < ApplicationRecord

	def message_time
  	created_at.strftime("%d/%m/%y at %l:%M %p")
 	end
end
