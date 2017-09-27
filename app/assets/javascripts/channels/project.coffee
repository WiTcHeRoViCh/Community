$ ->
	initProjChannel(1)
	
	$(document).on 'click', '.choose_set div', (event) ->
		if event.target.id == 'f_set'
			$('.choose_set div').attr('class','')
			event.target.className = "box_shadow"

			$('#first_prof_form').css('display','block')
			$('#second_prof_form').css('display', 'none')
		else
			$('.choose_set div').attr('class','')
			event.target.className = "box_shadow"

			$('#second_prof_form').css('display','block')
			$('#first_prof_form').css('display', 'none')

	$(document).on 'click', '#user_avatar button', ->
		$('#modal_write_mess').css('display','block')

	$(document).on 'click', 'body', (event) ->
		if event.target.id == 'modal_write_mess'
			$('#modal_write_mess').css('display','none')



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