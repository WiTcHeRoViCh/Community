$ ->
  initArticleChannel(1)

$(document).on 'click', '.btn-primary', (event) ->
	if event.target.id
		article_form = $(@).parents('form')
		article_form.children(".form_group").children()[1].value
		arr = []
		for i in [0..4]
  		arr[i] = $('#article_form').children(".form_group").children()[i].value
  	App.article.speak arr

$(document).on 'click', '.delete_art', (event) ->
	App.article.delete $(@).parents('.article').data('key')


initArticleChannel = (id) ->
	App.article = App.cable.subscriptions.create {
    channel: "ArticleChannel", articleId: id },

    received: (data) ->


    speak: (arr) ->
    	@perform 'speak', article: arr

    delete: (id) ->
    	@perform 'delete', id: id

