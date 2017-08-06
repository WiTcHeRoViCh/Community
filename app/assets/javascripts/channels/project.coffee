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

$(document).on 'click', '.delete_proj', (event) ->
	cur_user_code = $('.proj_group:last input').val()
	if confirm("You sure want to delete project?")
		App.project.deleteProj $(@).parents('.project').data('key'), cur_user_code
		$(@).parents('.project').remove()

initProjChannel = (id) ->
	App.project = App.cable.subscriptions.create {
    channel: "ProjectChannel", projectId: id },

    received: (data) ->
    	addArticle(data)


    speak: (arr, cur_id) ->
    	@perform 'speak', project: arr, current_user: cur_id

    deleteProj: (id, cur_user_code) ->
    	@perform 'deleteProj', id: id, cur_code: cur_user_code

addArticle = (data) ->
	if data['action'] == 'create'
		$('.articles').prepend(data['project'])