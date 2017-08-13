@PhotoForm = React.createClass
	getInitialState: ->
		images: ''
		user_id: @props.current_user.id
	
	handleChange: (event) ->
		name = event.target.name
		file = event.target.files[0]
		reader = new FileReader()
		reader.onload = (output) ->
			src = output.target.result
			out = $('#list')
			out.html("<img src='"+src+"' class='uploading_photo' name='"+escape(file.name)+"'>")			
		reader.readAsDataURL(file)
		@setState images: event.target.value	

	checkOnValid: ->
		btn = $('#photo_submit')
		if @state.images && @state.user_id == @props.current_user.id
			btn.css({"color": "#efefef", "cursor":"pointer"})
			return true
		else
			btn.css({"color": "#b4b4b4", "cursor":"default"})
			return false

	addPhoto: ->
		if @checkOnValid()
			src = $('.uploading_photo').attr('src')
			name = $('.uploading_photo').attr('name')

			@props.handleNewPhoto {images: src, user_id: @state.user_id, name: name}
			@setState @getInitialState()
			$('#list').html('')
			$('.mod_hw').css("display", "none");

	render: ->
		React.DOM.div null,
			React.DOM.div
				className: 'mod_photo_head'
				'Click "Обзор" and choose image for uploading'

			React.DOM.form
				id: 'photo_form'

				React.DOM.input
					type: 'file'
					name: 'images'
					ref: 'file'
					onChange: @handleChange
					value: @state.images

				React.DOM.output
					id: 'list'

				React.DOM.input
					type: 'hidden'
					name: 'user_id'
					value: @state.user_id

				React.DOM.div
					id: 'photo_submit'
					disabled: !@checkOnValid()
					onClick: @addPhoto
					'Upload photo'
