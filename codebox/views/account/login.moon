html = require "lapis.html"

class Login extends html.Widget
	content: =>
		h1 style: "background-color:red", "Login!"

		form method: 'POST', ->
			input type: 'hidden', name: 'csrf_token', value: @csrf_token
			input type: 'text', placeholder: 'Username', name: 'username', ''
			input type: 'password', placeholder: 'Password', name: 'password', ''
			input type: 'submit', value: 'Submit', ''
