@ArticleForm = React.createClass
	getInitialState: ->
		src: ''
		name: ''
		title: ''
		photo: ''
		description: ''
		importance: ''
		user_code: @props.current_user.code

	handleChange: (event) ->
		name = event.target.name
		@setState "#{name}": event.target.value

	handleFileChange: (event) ->
		name = event.target.name
		file = event.target.files[0]
		reader = new FileReader()
		reader.onload = (output) ->
			src = output.target.result
			out = $('#mini_art_photo')
			image = $('[name=image]')
			out.html("<img src='"+src+"' class='out_mini_photo' name='"+escape(file.name)+"'>")
			image.attr({'src': src, 'value': escape(file.name)})
			image.click()
		reader.readAsDataURL(file)
		@setState "#{name}": event.target.value

	valid: ->
		btn = $('.btn-primary')
		if @state.title && @state.description
			if @state.photo
				if @state.src && @state.name
					btn.css({"cursor": "pointer", "color":"#fff"})
					return true
				else
					btn.css({"cursor": "default", "color":"#686464"})
					return false

			btn.css({"cursor": "pointer", "color":"#fff"})
			return true
		else
			btn.css({"cursor": "default", "color":"#686464"})
			return false

	addArticle:  ->
		if @valid()

			@props.handleNewArticle @state
			@setState @getInitialState()
			$('#mini_art_photo').html('')
			$('.mod_hw').css("display", "none");

	setSrc: (event) ->
		@setState 'src': event.target.src
		@setState 'name': event.target.value

	render: ->
		React.DOM.form
			id: 'article_form'

			React.DOM.div
				className: 'form_group'
				'Title: '
				React.DOM.input
					className: 'form-control'
					type: 'text'
					name: 'title'
					value: @state.title
					onChange: @handleChange

			React.DOM.div
				className: 'form_group'
				'Photo: '
				React.DOM.input
					className: 'form-control'
					type: 'file'
					name: 'photo'
					value: @state.photo
					onChange: @handleFileChange

			React.DOM.output
				id: 'mini_art_photo'

			React.DOM.input
				type: 'hidden'
				name: 'image'
				value: ''
				onClick: @setSrc

			React.DOM.div
				className: 'form_group'
				'Description: '
				React.DOM.textarea
					className: 'form-control'
					type: 'text'
					name: 'description'
					value: @state.description
					onChange: @handleChange

			React.DOM.div
				className: 'form_group'
				'Importance: '
				React.DOM.input
					className: 'form-control'
					type: 'text'
					name: 'importance'
					value: @state.importance
					onChange: @handleChange

			React.DOM.div
				className: 'form_group'
				React.DOM.input
					className: 'form-control'
					type: 'hidden'
					name: 'user_code'
					value: @props.current_user.code

			React.DOM.span
				className: 'btn-primary'
				disabled: !@valid()
				onClick: @addArticle
				'Create news'

