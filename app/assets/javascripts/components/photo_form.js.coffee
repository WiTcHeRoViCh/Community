@PhotoForm = React.createClass
	getInitialState: ->
		image: ''
		name: ''
		images: ''
		user_id: @props.current_user.id
	
	handleChange: (event) ->
		name = event.target.name
		file = event.target.files[0]
		reader = new FileReader()
		reader.onload = (output) ->
			src = output.target.result
			out = $('#list')
			hid_field = $('[name=image]')
			out.html("<img src='"+src+"' class='uploading_photo' name='"+escape(file.name)+"'>")
			hid_field.attr({'src': src, 'value': escape(file.name)})
			hid_field.click()
		reader.readAsDataURL(file)
		@setState "#{name}": event.target.value


	checkOnValid: ->
		btn = $('#photo_submit')
		if @state.images && @state.user_id == @props.current_user.id && @state.name && @state.image
			btn.css({"color": "#efefef", "cursor":"pointer"})
			return true
		else
			btn.css({"color": "#b4b4b4", "cursor":"default"})
			return false

	addPhoto: ->
		if @checkOnValid()
			status = @UrlExists @state.image, (status) ->
				if status != '0' && status != '404'
					return true
				else
					return false

			if status
				@props.handleNewPhoto @state
				@setState @getInitialState()
				$('#list').html('')
				$('.mod_hw').css("display", "none");
			else
				@setState @getInitialState()
				$('#list').html('Please, reload your image!')


	UrlExists: (url, cb) ->
    	jQuery.ajax
        	url:      url,
        	dataType: 'text',
        	type:     'GET',
        	complete: (xhr) ->
        	    if typeof cb == 'function'
        	       cb.apply(this, [xhr.status]);

    saveSrc: (event) ->
    	@setState "image": event.target.src
    	@setState "name": event.target.value


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

				React.DOM.input
					type: 'hidden'
					name: 'image'
					value: ''
					onClick: @saveSrc

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
