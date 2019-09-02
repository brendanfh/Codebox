html = require 'lapis.html'

class ErrorList extends html.Widget
	content: =>
		return unless @errors

		div class: 'error-list', ->
			ul ->
				for err in *@errors
					if err.success then
						li class: 'success', -> text "Success: #{err.msg}"
					else
						li -> text "Error: #{err}"
