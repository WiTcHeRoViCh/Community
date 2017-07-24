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
					 placeholder: 'Photo'
					 type: 'text'
					 onChange: @handleChange
					 value: @state.photo
					 name: 'photo'

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
				className: 'proj_group1'
				React.DOM.input
					 placeholder: 'Crew'
					 type: 'text'
					 onChange: @handleChange
					 value: @state.crew
					 name: 'crew'

			React.DOM.div
				className: 'proj_group'
				React.DOM.input
					 type: 'hidden'
					 onChange: @handleChange
					 value: @state.user_id

			React.DOM.div
				className: 'proj_group'
				React.DOM.input
					 type: 'hidden'
					 onChange: @handleChange
					 value: @state.user_code

				React.DOM.span
					id: 'submit'
					disabled: !@valid()
					onClick: @addProject
					'Create new project'