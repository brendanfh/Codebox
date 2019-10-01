html = require "lapis.html"
import to_json from require 'lapis.util'

class Login extends html.Widget
	content: =>
		h1 "Login"

		div class: 'content', ->
			div class: 'split-1-1', ->
				form method: 'POST', ->
					input type: 'hidden', name: 'csrf_token', value: @csrf_token
					input type: 'text', placeholder: 'Username', name: 'username', ''
					input type: 'password', placeholder: 'Password', name: 'password', ''
					input type: 'submit', value: 'Submit', ''

				div class: 'content', ->
					h1 "Don't have an account?"
					div class: 'ta-center', ->
						text "Create one "
						a href: (@url_for 'account.register'), style: 'text-decoration: underline; color: #3333ff', 'here'
						text '.'

