@ArticleForm = React.createClass
	getInitialState: ->
		title: ''
		photo: ''
		description: ''
		importance: ''
		user_code: @props.current_user.code

	handleChange: (event) ->
		name = event.target.name
		@setState "#{name}": event.target.value

	valid: ->
		btn = $('.btn-primary')
		if @state.title && @state.photo && @state.description && @state.importance
			btn.css({"cursor": "pointer", "color":"#fff"})
			btn.attr('id', @props.current_user.id);
			return true
		else
			btn.css({"cursor": "default", "color":"#686464"})
			btn.attr('id', '');
			return false

	addArticle:  ->
		if @valid()			
			@props.handleNewArticle @state
			@setState @getInitialState()
			$('.mod_hw').css("display", "none");

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
					type: 'text'
					name: 'photo'
					value: @state.photo
					onChange: @handleChange

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

