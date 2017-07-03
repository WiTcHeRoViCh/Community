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
	tabs[0].id = "current"

	tabs.click(function(e) {
		tabs.removeAttr('id');

		e.target.id = "current"
	});

});

// var a = ' 300 × 198 - nest.by ';

// function my(x) {
// 	v = [];
// 	c = document.getelementsbyclassname('rg_ilmn');

// 	for (var i = 0; i < 10; i++) {
// 		if (findsize(c[i].innertext) == x) {
// 			v.push(c)
// 			console.log('yes')
// 		}
// 	}
// }

// function findsize(x) {
// 	b = [];
// 	for (i = 0; i < x.length; i++) {
//   	if (/\d/.test(x[i]) || x[i] == "×") {
//     	b.push(x[i])
//   	}
// 	}
// 	return b.join('')	
// }