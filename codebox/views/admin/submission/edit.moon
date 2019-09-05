html = require "lapis.html"

class AdminSubmissionEdit extends html.Widget
	content: =>
		link rel: "stylesheet", href: "/static/css/highlight/vs2015.css"
		script ->
			text "hljs.initHighlightingOnLoad();hljs.initLineNumbersOnLoad();"

		div class: 'content', ->
			a class: 'button', href: (@url_for 'admin.submission.delete', {}, { 'submission_id': @job.job_id }), 'Delete submission'

			widget (require('views.ssr.job_result')(@job))

			div class: 'header-line', ->
				div -> text "#{@job.lang} code"

			pre -> code class: @job.lang, ->
				text @job.code

