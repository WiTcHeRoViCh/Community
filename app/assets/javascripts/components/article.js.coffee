@Article = React.createClass
	render: ->
		React.DOM.div
			className: 'article'
			'data-key': @props.article.id
			
			React.DOM.div
				className: 'art_title'
				'Title: '+@props.article.title

			React.DOM.div
				className: 'art_photo'
				if @props.article.photo.url
					React.DOM.img
						src: @props.article.photo.url

			React.DOM.div
				className: 'art_desc'
				@props.article.description

			React.DOM.div
				className: 'art_imp'
				@props.article.importance

			React.DOM.div
				className: 'art_user'
				'Created by: '+@props.article.user_code

			if @props.current_user && @props.current_user.code == @props.article.user_code
				React.DOM.div
					className: 'art_set'
					React.DOM.div
						className: 'art_edit'
						React.DOM.a
							className: 'edit_article'
							href: "articles/"+@props.article.id+"/edit"
							'Edit'

					React.DOM.div
						className: 'art_edit'
						React.DOM.button
							className: 'delete_art'
							'Delete'
