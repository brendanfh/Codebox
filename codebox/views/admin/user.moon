html = require "lapis.html"

class AdminUsers extends html.Widget
	content: =>
		h1 'Users'

		div class: 'content', ->
			for user in *@users
				div class: 'w50 left pad-12', ->
					div class: 'option-line', ->
						span "#{user.username}"
						div class: 'button-list', ->
							button { 'data-user-reset-password': user.username }, 'Reset password'
							button { 'data-user-delete': user.username }, 'Delete'
					div class: 'box', ->
						div class: 'highlight pad-12 split-lr', ->
							span "Nickname:"
							span "#{user.nickname}"
						div class: 'highlight pad-12 split-lr', ->
							span "Email:"
							span "#{user.email}"
