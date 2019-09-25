html = require 'lapis.html'

class Navigation extends html.Widget
	content: =>
		div class: 'navbar', ->
			div class: 'navbar-logo', ->
				img src: '/static/imgs/logo.png'

			ul ->
				a -> li class: { 'selected': @navbar.selected == 0 }, 'Leaderboard'
				a href: (@url_for 'problem'), -> li class: { 'selected': @navbar.selected == 1 }, 'Problems'
				a href: (@url_for 'submission.list'), -> li class: { 'selected': @navbar.selected == 2 }, 'Submissions'

			div class: 'navbar-username', ->
				if @user
					text @user.username
					div class: 'navbar-username-dropdown', ->
						div class: 'navbar-username-dropdown-option', ->
							a href: (@url_for 'account.account'), "My Account"
						div class: 'navbar-username-dropdown-option', ->
							a href: (@url_for 'account.logout'), "Log out"
				else
					a href: (@url_for 'account.login'), "Log in"
					div class: 'navbar-username-dropdown', ->
						div class: 'navbar-username-dropdown-option', ->
							a href: (@url_for 'account.register'), "Register"

