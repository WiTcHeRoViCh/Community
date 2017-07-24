@Projects = React.createClass
	getInitialState: ->
		projects: @props.data
		current_user: @props.current_user

	getDefaulProps: ->
		projects: []

	addProject: (project) ->
		projects = @state.projects.slice()
		projects.unshift project
		@setState projects: projects


	showForm: ->
		$('.proj_hw').toggle("slow");

	render: ->
		React.DOM.div
			className: 'projects'
			if @props.current_user
				React.DOM.div
					className: 'new_proj'
					React.DOM.button
						id: 'proj_button'
						onClick: @showForm
						'Add projects'
					React.DOM.div
						className: 'proj_hw'
						React.DOM.div
							id: 'proj_mod'
							React.createElement ProjectForm, handleNewProject: @addProject, current_user: @props.current_user

			React.DOM.div
				className: 'all_proj'

				for project in @state.projects
					React.createElement Project, key: project.id, project: project, current_user: @props.current_user