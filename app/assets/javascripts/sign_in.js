$(document).ready(function(){

	sign = $('#sign_in');
	cont = $('#cont_sign');

	sign.click(function() {
		cont.css("display", "block");
	});

	$(document).click(function(event) {
		if (  $(event.target).is($('.mod_hw')) ) {
			cont.css("display", "none");
		}
	});

});
