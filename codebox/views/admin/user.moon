html = require "lapis.html"

class AdminUsers extends html.Widget
	content: =>
		h1 'Users'

		div class: 'content', ->
			div class: 'bcolor-pd pad-12 split-6', ->
				span "Id"
				span "Username"
				span "Nickname"
				span "Email"
				span "Options"

			div class: 'box', ->
				for user in *@users
					div class: 'highlight pad-12 split-6', ->
						span "#{user.id}"
						span "#{user.username}"
						span "#{user.nickname}"
						span "#{user.email}"
						span class: 'button-list', ->
							button { 'data-user-reset-password': user.username }, 'Reset password'
						span class: 'button-list', ->
							button { 'data-user-delete': user.username }, 'Delete'
