html = require "lapis.html"

class Problems extends html.Widget
	content: =>
		h1 "Problems"

		div class: 'content', ->
			for prob in *@problems
				div class: 'tabbed-split tab-64 primary-dark', ->
					span class: 'pad-12', prob.letter

					div prob.name