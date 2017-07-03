@UserForm = React.createClass
	getInitialState: ->
		name: ''
		surname: ''
		age: ''
		post: ''
	
	handleChange: (event) ->
		name = event.target.name
		@setState "#{name}": event.target.value

	valid: ->
		@state.name && @state.surname && @state.age && @state.post	

	handleSubmit: (event) ->
		event.preventDefault()
		$.post '/users', {user: @state}, (data) =>
			@setState @getInitialState()
		, 'JSON', 

		success: (data, success, xhr) ->
      console.log(data)

	render: ->

		React.DOM.form
			className: 'form-inline'
			onSubmit: @handleSubmit
			method: 'post'
			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Name'
					name: 'name'
					value: @state.name
					onChange: @handleChange

			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Surname'
					name: 'surname'
					value: @state.surname
					onChange: @handleChange

			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'number'
					className: 'form-control'
					placeholder: 'Age'
					name: 'age'
					value: @state.age
					onChange: @handleChange

			React.DOM.div
				className: 'form-group'
				React.DOM.input
					type: 'text'
					className: 'form-control'
					placeholder: 'Post'
					name: 'post'
					value: @state.post
					onChange: @handleChange

			React.DOM.button
				type: 'submit'
				className: 'btn btn-primary'
				disabled: !@valid()
				'Create user'