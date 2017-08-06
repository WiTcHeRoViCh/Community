// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's 
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require react
//= require react_ujs
//= require components
//= require_tree .
//= require bootstrap-sprockets

if (typeof window !== 'undefined') {
    window.React = React;
}


$(document).ready(function() {
	tabs = $('#root_tabs ul li a');
	getCookie("render") ? $('[rel ="'+ getCookie("render") +'"]')[0].id = "current" : tabs[0].id = "current"
	tab = $('#tab')
	getCookie("render") ? $('#tab [name = "'+getCookie("render")+'"]').removeAttr('class') : $('#tab [name = "root"]').removeAttr('class')

	tabs.click(function(e) {
		tabs.removeAttr('id');
		e.target.id = "current"

		tab.children().attr('class', 'tabs')
		$('[name="'+e.target.rel+'"]').removeAttr('class')

		document.cookie = "render = "+e.target.rel
	});


	$('#root_tabs ul li a').each(function(index){
  		$('#root_tabs ul li a')[index].accessKey = (index+1).toString();
	});


	$('.room-channel').click(function() {
		$('#message_body').focus();
		document.getElementsByClassName("message")[$('.message').length-1].scrollIntoView();
		mes_body_focus();
	})

	if (getCookie("render") == "chat") {
		mes_body_focus();
		document.getElementsByClassName("message")[$('.message').length-1].scrollIntoView()
	}

	$('.message p a').click(function(e) {update(e)});

	
	function update(e){
  	mes = $(e.target).parents('div.message');
  	id = $(mes).data('message-id');
  	span = $(mes).find('span')[0];
  	text = span.innerText;
  	text_2 = span.innerText;
  	span.innerHTML = "<input id='message_body' name='message[update_body]' value='"+text+"'> "
  	$('[name="message[update_body]"]').focus();

 		$('[name="message[update_body]"]').focusout(function(e) {
			span.innerHTML = text_2;
			mes_body_focus();
		});
	}

	function mes_body_focus() {
		$(document).keydown(function() {
			document.getElementsByClassName("message")[$('.message').length-1].scrollIntoView()
			$('#message_body').focus();
		})
	}

	function getCookie(name) {
  	var matches = document.cookie.match(new RegExp(
    	"(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
  	));
  	return matches ? decodeURIComponent(matches[1]) : undefined;
	}

});
