html = require 'lapis.html'

class Navigation extends html.Widget
	content: =>
		div class: 'navbar', ->
			div class: 'navbar-logo', ->
				img src: '/static/imgs/logo.png'

			ul ->
				a -> li class: { 'selected': @navbar.selected == 0 }, 'Leaderboard'
				a href: (@url_for 'problem'), -> li class: { 'selected': @navbar.selected == 1 }, 'Problems'
				a -> li class: { 'selected': @navbar.selected == 2 }, 'Submissions'
