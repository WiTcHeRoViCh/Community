@Conversation = React.createClass
	
	userProfile: (id) ->
		document.location = "/users/"+id+"/profiles/"+id

	conversationShow: (id) ->
		document.location = "/conversations/"+id

	render: ->
		React.DOM.div 
			className: 'conversation'
			'data-key': @props.conversation.id
			if @props.current_user.id == @props.conversation.sender_id
				React.DOM.div
					className: 'recipient_inf'
					React.DOM.img
						className: 'recipient_avatar'
						src: @props.conversation.recipient.avatar.url

					React.DOM.div
						className: 'recipient_name'
						onClick: => @userProfile(@props.conversation.recipient.id)
						@props.conversation.recipient.name+' '+@props.conversation.recipient.surname

			else
				React.DOM.div
					className: 'recipient_inf'
					React.DOM.img
						className: 'recipient_avatar'
						src: @props.conversation.sender.avatar.url

					React.DOM.div
						className: 'recipient_name'
						onClick: => @userProfile(@props.conversation.sender.id)
						@props.conversation.sender.name+' '+@props.conversation.sender.surname
				

			React.DOM.div
				className: 'last_message'
				onClick: => @conversationShow(@props.conversation.id)
				@props.conversation.last_message.sender.name+': '+@props.conversation.last_message.body

			React.DOM.div
				className: 'right_inf_panel'
				if @props.current_user.id == @props.conversation.sender_id
					if @props.current_user.id == @props.conversation.last_message.user_id
						if !@props.conversation.last_message.read
							'unread'
					else
						@props.conversation.recipient_unread_mess if @props.conversation.recipient_unread_mess > 0

				else
					if @props.current_user.id == @props.conversation.last_message.user_id
						if !@props.conversation.last_message.read
							'unread'
					else
						@props.conversation.sender_unread_mess if @props.conversation.sender_unread_mess > 0

