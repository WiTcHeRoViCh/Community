@Conversations = React.createClass
	getInitialState: ->
		conversations: @props.data
		current_user: @props.current_user

	getDefaulProps: ->
		conversations: []
		current_user: ''

	deleteConversation: (conversation) ->


	setSubscription: ->


	render: ->
		React.DOM.div
			id: 'conversations'

			for conversation in @state.conversations
				React.createElement Conversation, key: conversation.id, conversation: conversation, current_user: @props.current_user, handleDeleteConversation: @deleteConversation
