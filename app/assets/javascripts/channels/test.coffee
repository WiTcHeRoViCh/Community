$ ->
	initCableChannel()

initCableChannel = () ->
	App.anon_message = App.cable.subscriptions.create {
    	channel: "AnonMessageChannel", id: '1'},

    	received: (data) ->
