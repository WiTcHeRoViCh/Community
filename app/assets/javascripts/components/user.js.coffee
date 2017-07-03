@User = React.createClass
	render: ->
		React.DOM.li
			className: 'user'
			React.DOM.img
				className: 'u_av'
				src: "/assets/example.jpg"
			
			React.DOM.div
				className: 'u_full_name'
				React.DOM.div
					className: 'u_name'
					@props.user.name
				React.DOM.div
					className: 'u_surname'
					@props.user.surname
