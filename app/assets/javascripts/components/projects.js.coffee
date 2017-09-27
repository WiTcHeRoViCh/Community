@Projects = React.createClass
	getInitialState: ->
		projects: @props.data
		current_user: @props.current_user

	showForm: ->
		$('.proj_hw').toggle("slow");

	createProject: (project) ->
		App.project.createProject project, @state.current_user.id

	componentDidMount: ->
		@setSubscription()

	setSubscription: ->
		App.project = App.cable.subscriptions.create("ProjectChannel", {

			connected: ->

			disconnected: ->

			received: (data) ->
				@addProject data

			createProject: (project, cur_id) ->
				@perform 'speak', project: project, current_user: cur_id

			addProject: @addProject
		})

	addProject: (data) ->
		if data['action'] == 'create'
			projects = @state.projects.slice()
			projects.unshift data['project']
			@setState projects: projects

			$('.articles').prepend(data['article'])




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
							React.createElement ProjectForm, handleNewProject: @createProject, current_user: @props.current_user

			React.DOM.div
				className: 'all_proj'

				for project in @state.projects
					React.createElement Project, key: project.id, project: project, current_user: @props.current_user