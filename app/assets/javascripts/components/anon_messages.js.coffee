@Anon_messages = React.createClass
	getInitialState: ->
		anon_messages: @props.anon_messages
		current_user: @props.current_user
		user: @props.user
		body: ''

	handleChange: (event) ->
		name = event.target.name
		@setState "#{name}": event.target.value
		

	valid: ->
		if @state.body
			$('#anon_message_form img').css({'background': '#f4f5f4', 'cursor': 'pointer'})
			return true
		else
			$('#anon_message_form img').css({'background': '#bad1da', 'cursor': 'default'})
			return false


	addAnonMessage: (event) ->
		if @valid()
			App.anon_message.addAnonMessage @state.body, @state.user.id
			@setState body: ''

	deleteMessage: (event) ->
		mess_id = $(event.target).parents('.anon_message').attr('data-key')
		user_id = @state.current_user.id

		App.anon_message.deleteMessage mess_id, user_id if confirm("Delete '"+mess_id+"' message?")

	componentDidMount: ->
		@setSubscription()

	setSubscription: ->
		App.anon_message = App.cable.subscriptions.create("AnonMessageChannel", {
			connected: ->

			disconnected: ->

			received: (data) ->
				@newAnonMessage data
				@deleteAnonMessage data


			addAnonMessage: (anon_message, user_id) ->
				@perform 'addAnonMessage', anon_message: anon_message, user_id: user_id

			deleteMessage: (anon_mess_id, user_id) ->
				@perform 'deleteMessage', anon_mess_id: anon_mess_id, user_id: user_id

			newAnonMessage: @newAnonMessage
			deleteAnonMessage: @deleteAnonMessage
		})

	newAnonMessage: (data) ->
		if data['action'] == 'create'
			anon_message = data['anon_message']
			anon_messages = @state.anon_messages.slice()
			anon_messages.unshift anon_message
			@setState anon_messages: anon_messages


	deleteAnonMessage: (data) ->
		if data['action'] == 'delete'
			anon_mess_id = data['anon_message_id']
			anon_messages = @state.anon_messages.slice()
			index = @findElemIndex(anon_messages, anon_mess_id)
			anon_messages.splice(index, 1)
			
			@setState anon_messages: anon_messages


	findElemIndex: (arr, element) ->
		for i in [0..arr.length-1]
			if arr[i]['id'].toString() == element.toString()
				return i
		return nil

	render: ->
		React.DOM.div
			id: 'anon_messages'

			React.DOM.div
				id: 'all_anon_mess'
				for message in @state.anon_messages
					React.DOM.div
						className: 'anon_message'
						'data-key': message.id

						if @state.current_user.id == @state.user.id
							React.DOM.div
								className: 'delete_anon_message'
								React.DOM.button
									className: 'anon_delete_button'
									onClick: @deleteMessage
									'Delete'

						React.DOM.div
							className: 'anon_body'
							message.body

			if @state.current_user.id != @state.user.id
				React.DOM.div
					id: 'anon_message_form'
					React.DOM.form null,
						React.DOM.textarea
							type: 'text'
							name: 'body'
							placeholder: 'Write message'
							value: @state.body
							onChange: @handleChange

						React.DOM.img
							src: '/assets/pointer_2'
							title: 'Send message'
							onClick: @addAnonMessage
							disabled: !@valid()
							value: ''
