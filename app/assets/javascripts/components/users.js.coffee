@Users = React.createClass
	getInitialState: ->
    users: @props.data
 
  getDefaultProps: ->
    users: []

  addUser: (user) ->
  	users = @state.users.slice()
  	users.push user
  	@setState users: users

  render: ->
  	React.DOM.div
  		className: 'users'
  		React.DOM.h2
  			className: 'title'
  			'Users'

  		React.DOM.table
  			className: 'table table-bordered'
  			React.DOM.thead null,
  				React.DOM.tr null,
  					React.DOM.th null, 'Name'
  						React.DOM.th null, 'Surname'
  						React.DOM.th null, 'Age'
  						React.DOM.th null, 'Post'

  			React.DOM.tbody null,
  				for user in @state.users
  					React.createElement User, key: user.id, user: user
