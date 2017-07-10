$ ->
  if $('#messages').length > 0
    alert('true')
    initCableChannel($('#messages'))

$(document).on 'click', '.room-channel', ->
  initCableChannel($(@))


$(document).on 'keypress', '#message_body', (event) ->
  if event.keyCode is 13
    message_form = $(@).parents('form')
    current_user_id = $('#message_user_id').val()

    if message_form.hasClass('new_message')
      App.room.speak event.target.value, current_user_id
      event.target.value = ''
      event.preventDefault()
    else
      mes = $(event.target).parents('div.message');
      id = $(mes).data('message-id');
      val = $(event.target).val();
      App.room.update val, id, current_user_id

$(document).on 'click', '.destroy_message', ->
  user_id = $('#message_user_id').val()
  App.room.destroy $(@).parents('.message').data('message-id'), user_id

initCableChannel = (roomElement) ->
  App.room = App.cable.subscriptions.create {
    channel: "RoomChannel", roomId: roomElement.data('room-id') },

    received: (data) ->
      appendMessage(data)
      destroyMessage(data)
      updateMessage(data)

    speak: (body, current_user_id) ->
      @perform 'speak', body: body, current_user_id: current_user_id

    destroy: (id) ->
      @perform 'destroy', id: id

    update: (val, id) ->
      @perform 'update', val: val, id: id

appendMessage = (data) ->
  if data['action'] == 'create'
    $('#messages').append data['message']

destroyMessage = (data) ->
  if data['action'] == 'destroy'
    message = $("*[data-message-id=#{data['id']}]")
    message.remove();

updateMessage = (data) ->
  if data['action'] == 'update'
    message = $("*[data-message-id=#{data['id']}]")
    message.html(data['message'])
    message.find('a').click ->
      mes = $(@).parents('.message')
      id = $(mes).data('message-id');
      span = $(mes).find('span')[0];
      text = span.innerText;
      text_2 = span.innerText;
      span.innerHTML = "<input id='message_body' name='message[update_body]' value='"+text+"'> "
      $('[name="message[update_body]"]').focus();

      $('[name="message[update_body]"]').focusout ->
        span.innerHTML = text_2;