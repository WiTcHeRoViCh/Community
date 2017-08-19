@Photos = React.createClass

	getInitialState: ->
		photos: @props.photos
		current_user: @props.current_user
		user: @props.user
	
	showForm: ->
		$('.photo_mod_hw').css("display", "block")

	hideForm: (event) ->
		if $(event.target).is($('.mod_hw'))
			$('.mod_hw').css("display", "none");
		
	uploadPhoto: (photo) ->
		App.photo.addPhoto photo

	deletePhoto: (photo_id, user_id) ->
		App.photo.deletePhoto photo_id, user_id

	componentDidMount: ->
		@setSubscription()

	setSubscription: ->
		App.photo = App.cable.subscriptions.create("PhotoChannel", {
			connected: ->

			disconnected: ->

			received: (data) ->
				@prependPhoto data
				@deleteP data


			addPhoto: (photo) ->
				@perform 'addPhoto', photo: photo

			deletePhoto: (photo_id, user_id) ->
				@perform 'deletePhoto', photo_id: photo_id, user_id: user_id

			prependPhoto: @prependPhoto
			deleteP: @deleteP
		})

	prependPhoto: (data) ->
		if data['action'] == 'create'
			photos = @state.photos.slice()
			photos.unshift data['photo']
			@setState photos: photos

	deleteP: (data) ->
		if data['action'] == 'delete'
			photos = @state.photos.slice()
			photo = data['photo']
			index = @findElemIndex(photos, photo)
			photos.splice(index, 1)
			@setState photos: photos

	findElemIndex: (photos, photo) ->
		for i in [0..photos.length-1]
			if photos[i]['id'] == photo['id']
				return i
		return nil

	render: ->
		React.DOM.div
			id: 'all_photos'

			if @state.current_user.id == @state.user.id
				React.DOM.div
					id: 'for_adding_photo'
					React.DOM.span null, 'Your photos: '
					React.DOM.img
						id: 'upload_photo'
						title: 'Upload new photo'
						src: '/assets/circle(1)'
						onClick: @showForm
			
					React.DOM.div
						className: 'mod_hw'
						onClick: @hideForm
						React.DOM.div
							id: 'photo_mod'
							React.createElement PhotoForm, handleNewPhoto: @uploadPhoto, current_user: @state.current_user

			React.DOM.div
				id: "photos"

				for photo in @state.photos
					React.createElement Photo, key: photo.id, photo: photo, current_user: @state.current_user, handleDeletePhoto: @deletePhoto