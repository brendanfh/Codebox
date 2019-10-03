html = require "lapis.html"

class AdminUsers extends html.Widget
	content: =>
		h1 'Users'

		div class: 'content', ->
			div class: 'bcolor-pd pad-12 split-6', ->
				span "Username"
				span "Id"
				span "Nickname"
				span "Email"
				span "Options"

			div class: 'box', ->
				for user in *@users
					div class: 'highlight pad-12 split-6', ->
						span "#{user.username}"
						span "#{user.id}"
						span "#{user.nickname}"
						span "#{user.email}"
						span class: 'button-list', ->
							button { 'data-user-reset-password': user.username }, 'Reset password'
						span class: 'button-list', ->
							button { 'data-user-delete': user.username }, 'Delete'
