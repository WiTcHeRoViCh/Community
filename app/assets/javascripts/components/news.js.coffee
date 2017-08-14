@News = React.createClass
	getInitialState: ->
		articles: @props.data
		current_user: @props.current_user

	getDefaulProps: ->
		articles: []

	addArticle: (article) ->
		App.article.addArticle article

	showFormA: ->
		$('.mod_hw').css("display", "block");

	hideForm: (event) ->
		if $(event.target).is($('.mod_hw'))
			$('.mod_hw').css("display", "none");

	componentDidMount: ->
		@setSubscription()

	setSubscription: ->
		App.article = App.cable.subscriptions.create("ArticleChannel", {
			connected: ->

			disconnected: ->

			received: (data) ->
				@prependArticle data
				@deleteA data


			addArticle: (article) ->
				@perform 'addArticle', article: article

			deleteAhoto: (article_id, user_id) ->
				@perform 'deleteAhoto', article_id: article_id, user_id: user_id

			prependArticle: @prependArticle
			deleteA: @deleteA
		})

	prependArticle: (data) ->
		if data['action'] == 'create'
			articles = @state.articles.slice()
			articles.unshift data['article']
			@setState articles: articles

	render: ->
		React.DOM.div null,
			if @props.current_user
				React.DOM.div null,
					React.DOM.button
						id: 'art_button'
						onClick: @showFormA
						'Add news'

					React.DOM.div
						className: 'mod_hw'
						onClick: @hideForm
						React.DOM.div
							id: 'art_mod'
							React.createElement ArticleForm, handleNewArticle: @addArticle, current_user: @props.current_user

			React.DOM.div
				className: 'articles'

				for article in @state.articles
					React.createElement Article, key: article.id, article: article, current_user: @props.current_user
