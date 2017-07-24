$ ->
	initProjChannel(1)

$(document).on 'click', '#submit', (event) ->
	if $(event.target).attr('rel')
		form = $(@).parents('form')
		cur_id = $(event.target).attr('rel')
		arr = []
		for i in [0..5]
			arr[i] = form.children('div').children()[i].value
		App.project.speak arr, cur_id

initProjChannel = (id) ->
	App.project = App.cable.subscriptions.create {
    channel: "ProjectChannel", projectId: id },

    received: (data) ->
    	addArticle(data)


    speak: (arr, cur_id) ->
    	@perform 'speak', project: arr, current_user: cur_id

addArticle = (data) ->
	if data['action'] == 'create'
		$('.articles').prepend(data['project'])