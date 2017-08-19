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

	deleteArticle: (article_id, user_id) ->
		App.article.deleteArticle article_id, user_id

	setSubscription: ->
		App.article = App.cable.subscriptions.create("ArticleChannel", {
			connected: ->

			disconnected: ->

			received: (data) ->
				@prependArticle data
				@deleteA data


			addArticle: (article) ->
				@perform 'addArticle', article: article

			deleteArticle: (article_id, user_id) ->
				@perform 'deleteArticle', article_id: article_id, user_id: user_id

			prependArticle: @prependArticle
			deleteA: @deleteA
		})

	prependArticle: (data) ->
		if data['action'] == 'create'
			articles = @state.articles.slice()
			articles.unshift data['article']
			@setState articles: articles

	deleteA: (data) ->
		if data['action'] == 'delete'
			articles = @state.articles.slice()
			article_id = data['article_id']
			index = @findElemIndex(articles, article_id)

			articles.splice(index, 1)
			@setState articles: articles

	findElemIndex: (arr, element) ->
		for i in [0..arr.length-1]
			if arr[i]['id'] == element
				return i
		return -1

	render: ->
		React.DOM.div null,
			if @props.current_user && !@props.user
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
					React.createElement Article, key: article.id, article: article, current_user: @props.current_user, handleDeleteArticle: @deleteArticle
