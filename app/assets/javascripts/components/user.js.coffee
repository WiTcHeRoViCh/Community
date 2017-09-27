@User = React.createClass

	toUserProfile: (id) ->
		document.location = "/users/"+id+"/profiles/"+id

	render: ->
		React.DOM.li
			className: 'user'
			React.DOM.img
				className: 'u_av'
				src: @props.user.avatar.url
			
			React.DOM.div
				className: 'u_full_name'
				onClick: => @toUserProfile(@props.user.id)
				React.DOM.div
					className: 'u_name'
					@props.user.name

				React.DOM.div
					className: 'u_surname'
					@props.user.surname

