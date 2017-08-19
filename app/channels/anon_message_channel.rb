 # frozen_string_literal: true
class AnonMessageChannel < ApplicationCable::Channel

	def subscribed
		stream_from 'anon_maessage_channal'
	end

	def addAnonMessage(data)
		anon_message = data['anon_message']
		user_id = data['user_id']
		user = User.find(user_id)

		new_anon_mess = user.anonymous_messages.new(body: anon_message)

		if new_anon_mess.save!
			ActionCable.server.broadcast(
    			'anon_maessage_channal',
    			action: 'create',
    			anon_message: new_anon_mess
    		)
    	else

    	end
	end

	def deleteMessage(data)
		anon_message_id = data['anon_mess_id']
		user_id = data['user_id']

		user = User.find(user_id)

		anon_message = user.anonymous_messages.find(anon_message_id)

		if anon_message.delete
			ActionCable.server.broadcast(
    			'anon_maessage_channal',
    			action: 'delete',
    			anon_message_id: anon_message_id
    		)
		else

		end

	end


end