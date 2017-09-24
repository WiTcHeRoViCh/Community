@Message = React.createClass
	

	render: ->
		React.DOM.div
			className: 'conversation_message'
			'data-key': @props.message.id
			if @props.current_user.id == @props.message.sender.id
				React.DOM.div
					className: 'current_sender_message'
					@props.message.body

			else
				React.DOM.div
					className: 'recipient_message'
					@props.message.sender.name+': '+@props.message.body