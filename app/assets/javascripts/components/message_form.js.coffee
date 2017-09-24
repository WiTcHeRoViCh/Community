@MessageForm = React.createClass
	getInitialState: ->
		body: ''
		conversation_id: @props.conversation_id
		user_id: @props.current_user.id
		read: 'false'

	handleChange: (event) ->
		name = event.target.name
		@setState "#{name}": event.target.value

	createMessage: ->
		@props.handleCreateMessage @state
		@setState @getInitialState()

	render: ->
		React.DOM.form
			id: 'report_form'

			React.DOM.textarea
				id: 'conv_report_body'
				name: 'body'
				placeholder: 'Write Message'
				value: @state.body
				onChange: @handleChange

			if @state.body
				React.DOM.div
					id: 'conv_report_submit'
					onClick: @createMessage
					'Send'
		