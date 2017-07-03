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
  	React.DOM.ul
  		className: 'users'
  		for user in @state.users
  			React.createElement User, key: user.id, user: user
