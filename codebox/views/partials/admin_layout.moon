html = require "lapis.html"
AdminNavbar = require 'views.partials.admin_navbar'
ErrorList = require 'views.partials.error_list'

class DefaultLayout extends html.Widget
	content: =>
		html_5 ->
			head ->
				link rel: "stylesheet", href: "/static/css/core.css"

				script type: "text/javascript", src: "/static/js/main.js"

			body ->
				widget AdminNavbar
				widget ErrorList
				@content_for "inner"
