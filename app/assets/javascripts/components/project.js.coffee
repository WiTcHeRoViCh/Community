@Project = React.createClass
	render: ->
		React.DOM.div
			className: 'project'
			'data-key': @props.project.id

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
				'Approved: '+@props.project.approved.toString()

			React.DOM.div
				id: 'proj_user_code'
				@props.project.user_code

			if @props.current_user && @props.current_user.code == @props.project.user_code
				React.DOM.div
					className: 'art_set'
					React.DOM.div
						className: 'set'
						React.DOM.a
							className: 'proj_edit'
							href: 'users/'+@props.current_user.id+'/projects/'+@props.project.id+'/edit'
							'Edit'

					React.DOM.div
						className: 'set'
						React.DOM.button
							className: 'delete_proj'
							'Delete'
