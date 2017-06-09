@User = React.createClass
	render: ->
		React.DOM.tr null,
			React.DOM.td null, @props.user.name
			React.DOM.td null, @props.user.surname
			React.DOM.td null, @props.user.age
			React.DOM.td null, @props.user.post
