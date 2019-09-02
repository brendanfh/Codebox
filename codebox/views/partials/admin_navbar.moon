html = require 'lapis.html'

class AdminNavigation extends html.Widget
	content: =>
		div class: 'navbar', ->
			div class: 'navbar-logo', ->
				img src: '/static/imgs/logo.png'

			ul ->
				a (href: @url_for 'admin.user'), -> li class: { 'selected': @navbar.selected == 0 }, 'Users'
				a (href: @url_for 'admin.problem'), -> li class: { 'selected': @navbar.selected == 1 }, 'Problems'
				a (href: @url_for 'admin.submission'), -> li class: { 'selected': @navbar.selected == 2 }, 'Submissions'
				a (href: @url_for 'admin.competition'), -> li class: { 'selected': @navbar.selected == 3 }, 'Competitions'
