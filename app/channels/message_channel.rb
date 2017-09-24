# frozen_string_literal: true
class MessageChannel < ApplicationCable::Channel

	def follow(data)
		stream_from "message_channel_#{data['message_id']}"
	end

	def createMessage(data)
		conversation_id = data['message']['conversation_id']
		body = data['message']['body']
		user_id = data['message']['user_id']

		conversation = Conversation.find(conversation_id)
		message = conversation.reports.create(body: body, user_id: user_id)
		message = message.as_json.merge({sender: message.sender.as_json})

		ActionCable.server.broadcast(
    		"message_channel_#{conversation_id}",
    		action: 'create',
    		message: message
    	)
	end

end