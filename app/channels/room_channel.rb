# frozen_string_literal: true
class RoomChannel < ApplicationCable::Channel
  
  def subscribed
    stream_from 'room_channel_1'
  end
 
  def speak(data)
    body = data['body']
    current_user_id = data['current_user_id']
    name = data['name']
    message = Message.new(body: body, user_id: current_user_id, user_name: name)
 
    message.save!

    ActionCable.server.broadcast 'room_channel_1', action: 'create', id: current_user_id, message: render_message(message)
  end

  def destroy(data)
    message = Message.find(data['id'])

    message.destroy!

    ActionCable.server.broadcast(
      'room_channel_1',
      action: 'destroy',
      id: data['id']
    )
  end

  def update(data)
    body = data['val']
    id = data['id']

    message = Message.find(id)
    message.update(body: body)
    mess = render_message(message)
    mess = mess.gsub(/\n\t<div class = \"message\" data-message-id = [\d]+>\n\t\t\n\t  \t/, '')

    ActionCable.server.broadcast 'room_channel_1', action: 'update', id: id, message: mess
  end
 
  private
 
  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message})
  end

end
