html = require "lapis.html"
AdminNavbar = require 'views.partials.admin_navbar'
ErrorList = require 'views.partials.error_list'

class DefaultLayout extends html.Widget
	content: =>
		html_5 ->
			head ->
				link rel: "stylesheet", href: "/static/css/core.css"

				script type: "text/javascript", src: "/static/js/vendor/jquery.min.js"
				script type: "text/javascript", src: "/static/js/main.js"

				for s in *@scripts
					script type: "text/javascript", src: "/static/js/#{s}.js"

			body ->
				widget AdminNavbar
				widget ErrorList
				@content_for "inner"
