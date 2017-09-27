@ProjectForm = React.createClass
	getInitialState: ->
		title: ''
		photo: ''
		description: ''
		crew: ''
		approved: 'false'
		user_id: @props.current_user.id
		user_code: @props.current_user.code

	handleChange: (event) ->
		name = event.target.name
		@setState "#{name}": event.target.value

	handleChangePhoto: (event) ->
		name = event.target.name
		file = event.target.files[0]
		reader = new FileReader()
		reader.onload = (output) ->
			src = output.target.result
			out = $('#mini_proj_photo')
			image = $('[name=photo]')
			out.html("<img src='"+src+"' class='out_mini_photo_proj' name='"+escape(file.name)+"'>")
			image.attr({'src': src, 'value': escape(file.name)})
			image.click()

		reader.readAsDataURL(file)
		@setState 'photo': event.target.value

	valid: ->
		btn = $('#submit')
		if @state.title && @state.photo && @state.description && @state.crew
			btn.css({"cursor": "pointer", "color":"#000"})
			btn.attr('rel', @props.current_user.id)
			return true
		else
			btn.css({'cursor': 'default', 'color': '#7e7e7e'})
			btn.attr('rel', '')
			return false

	addProject: ->
		if @valid()
			@props.handleNewProject @state
			@setState @getInitialState()
			$('.out_mini_photo_proj').attr('src','')

	setPhotoUrl: (event) ->
		filename = event.target.value
		image_url = event.target.src
		@setState 'filename': filename
		@setState 'image_url': image_url

	render: ->
		React.DOM.form
			id: 'project_form'
			onSubmit: @handleSubmit

			React.DOM.div
				className: 'proj_group1'
				React.DOM.input
					 placeholder: 'Title'
					 type: 'text'
					 onChange: @handleChange
					 value: @state.title
					 name: 'title'

			React.DOM.div
				className: 'proj_group1'
				React.DOM.input
					 placeholder: 'Crew'
					 type: 'text'
					 onChange: @handleChange
					 value: @state.crew
					 name: 'crew'

			React.DOM.div
				id: 'new_p'

			React.DOM.div
				className: 'proj_group1'
				React.DOM.input
					 placeholder: 'Description'
					 type: 'text'
					 onChange: @handleChange
					 value: @state.description
					 name: 'description'

			React.DOM.div
				className: 'proj_group2'
				React.DOM.input
					 type: 'file'
					 onChange: @handleChangePhoto
					 value: @state.photo

				React.DOM.div
					id: 'mini_proj_photo'

				React.DOM.input
					type: 'hidden'
					name: 'photo'
					value: ''
					onClick: @setPhotoUrl

			React.DOM.div
				className: 'proj_group'
				React.DOM.input
					 type: 'hidden'
					 value: @state.user_id

			React.DOM.div
				className: 'proj_group'
				React.DOM.input
					 type: 'hidden'
					 value: @state.user_code

				React.DOM.span
					id: 'submit'
					disabled: !@valid()
					onClick: @addProject
					'Create new project'