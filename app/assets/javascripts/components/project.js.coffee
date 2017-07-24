@Project = React.createClass
	render: ->
		React.DOM.div
			className: 'project'

			React.DOM.div
				id: 'proj_title'
				@props.project.title

			React.DOM.div
				id: 'proj_photo'
				@props.project.photo

			React.DOM.div
				id: 'proj_description'
				@props.project.description

			React.DOM.div
				id: 'proj_crew'
				@props.project.crew

			React.DOM.div
				id: 'proj_approved'
				@props.project.approved.toString()

			React.DOM.div
				id: 'proj_user_code'
				@props.project.user_code
