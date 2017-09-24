@Messages = React.createClass
	getInitialState: ->
		messages: @props.data.reports
		conversation: @props.data
		current_user: @props.current_user

	deleteMessage: ->


	createMessage: (message) ->
		App.message.addMessage message

	componentDidMount: ->
		@setSubscription()

	setSubscription: ->
		App.message = App.cable.subscriptions.create("MessageChannel", {
			message_id: @state.conversation.id

			connected: ->
				@perform 'follow', message_id: @message_id

			disconnected: ->

			received: (data) ->
				@prependMessage data

			addMessage: (message) ->
				@perform 'createMessage', message: message

			prependMessage: @prependMessage
		})

	prependMessage: (data) ->
		if data['action'] == 'create'
			messages = @state.messages.slice()
			messages.push data['message']
			@setState messages: messages

	render: ->
		React.DOM.div
			id: 'conv_message_path'

			React.DOM.div
				id: 'conversation_messages'

				for message in @state.messages
					React.createElement Message, key: message.id, message: message, current_user: @state.current_user, handleDeleteMessage: @deleteMessage

			React.DOM.div
				id: 'conv_message_form'

				React.createElement MessageForm, current_user: @state.current_user, conversation_id: @state.conversation.id, handleCreateMessage: @createMessage