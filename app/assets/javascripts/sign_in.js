$(document).ready(function(){

	sign = $('#sign_in');
	cont = $('#cont_sign');
	button = $('.about');

	button.click(function() {
		
	});

	sign.click(function() {
			cont.append("<div class = 'mod_hw'><div class = 'mod_sign'></div></div>");
	});

	$(document).click(function(event) {
		if (  $(event.target).is($('.mod_hw')) ) {
			cont.html("");
		}
	});

});
