@Sessions = React.createClass
	getInitialState: ->
		code: ''
		password: ''

	handleChangeCode: (e) ->
    name = e.target.name
    @checkOnValid(e.target, e.target.value)
    @setState "#{ name }": e.target.value

	handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value

  checkOnValid: (e, value) ->
  	d = document
  	div = d.createElement('div')
  	div.className = "error_mes"
  	error = false
  
  	if value.length == 0
  		error = true
  		div.innerText = "This field is required"
  	else
  		if d.getElementsByClassName('error_mes')[0]
  			d.getElementsByName(e.name)[0].parentNode.getElementsByClassName('error_mes')[0].remove()

  	if error
  		e.parentNode.appendChild(div)

  valid: ->
    @state.code && @state.password  

  handleSubmit: (e) ->
    e.preventDefault()
    $.post 'create', { user: @state }, (data) =>
      @setState @getInitialState()
      document.location = '/'

	render: ->
		React.DOM.form
			id: 'form-inline'
			onSubmit: @handleSubmit
			method: 'post'
			autoComplete: "off"

			React.DOM.div
				className: 'form-group'
				'Code '
				React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Code'
          name: 'code'
          value: @state.code
          onChange: @handleChangeCode

			React.DOM.div
				className: 'form-group'
				'Password '
				React.DOM.input
          type: 'password'
          className: 'form-control'
          placeholder: 'Password'
          name: 'password'
          value: @state.password
          onChange: @handleChangeCode
			
			React.DOM.button
				type: 'submit'
				className: 'btn form-submit'
				disabled: !@valid()
				'Sign in'
