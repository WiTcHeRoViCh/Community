@Photo = React.createClass
	deletePhoto: ->
		@props.handleDeletePhoto @props.photo.id, @props.current_user.id

	render: ->
		React.DOM.div
			className: 'photo'
			'data-key': @props.photo.id

			if @props.current_user.id == @props.photo.user_id
				React.DOM.img
					className: 'delete_photo'
					src: '/assets/delete_photo_3'
					onClick: @deletePhoto

			React.DOM.img
				className: 'show_photo'
				src: @props.photo.images.url
