html = require 'lapis.html'
import to_json from require 'lapis.util'

class Register extends html.Widget
	content: =>
		h1 style: "background-color:red", "Register"

		p ->
			text (to_json @errors)

		form method: 'POST', ->
			p -> input type: 'hidden', name: 'csrf_token', value: @csrf_token
			p -> input type: 'text', placeholder: 'Username', name: 'username', required: true, ''
			p -> input type: 'password', placeholder: 'Password', name: 'password', required: true, ''
			p -> input type: 'password', placeholder: 'Confirm Password', name: 'password_confirmation', required: true, ''
			p -> input type: 'text', placeholder: 'Email', name: 'email', required: true, ''
			p -> input type: 'text', placeholder: 'Display Name', name: 'nickname', required: true, ''
			input type: 'submit', value: 'Submit', ''
