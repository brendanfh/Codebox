html = require "lapis.html"
markdown = require "markdown"

class AdminProblemPreview extends html.Widget
	content: =>
		div style: 'overflow:hidden', class: 'content', ->
			h1 @problem.name

			div class: 'problem-description', ->
				raw (markdown @problem.description)
