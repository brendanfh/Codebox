html = require 'lapis.html'
import to_json from require 'lapis.util'

class Register extends html.Widget
	content: =>
		h1 "Register"

		div class: 'content', ->
			div class: 'split-1-1', ->
				form method: 'POST', ->
					input type: 'hidden', name: 'csrf_token', value: @csrf_token

					label for: 'username', 'Username'
					p -> input type: 'text', placeholder: 'Username', name: 'username', required: true, ''

                    div class: 'split-2', ->
                        div ->
                            label for: 'password', 'Password'
                            p -> input type: 'password', placeholder: 'Password', name: 'password', required: true, ''

                        div ->
                            label for: 'password_confirmation', 'Confirm Password'
                            p -> input type: 'password', placeholder: 'Confirm Password', name: 'password_confirmation', required: true, ''

					label for: 'email', 'Email'
					p -> input type: 'text', placeholder: 'Email', name: 'email', required: true, ''

					label for: 'nickname', 'Display name'
					p -> input type: 'text', placeholder: 'Display Name', name: 'nickname', required: true, ''

					input class: 'mar-t-24', type: 'submit', value: 'Submit', ''

				div class: 'content', ->
					h1 'Already have an account?'
					div style: 'text-align: center', ->
						text "Log in "
						a href: (@url_for 'account.login'), style: 'text-decoration: underline; color:#3333ff', 'here'
						text '.'
