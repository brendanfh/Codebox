html = require "lapis.html"
Navbar = require 'views.partials.navbar'

class DefaultLayout extends html.Widget
	content: =>
		html_5 ->
			head ->
				link rel: "stylesheet", href: "static/css/core.css"

				script type: "text/javascript", src: "static/js/main.js"

			body ->
				widget Navbar
				@content_for "inner"
