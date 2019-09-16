html = require "lapis.html"

class AdminSubmissionEdit extends html.Widget
	content: =>

		div class: 'content', ->
			a class: 'button', href: (@url_for 'admin.submission.delete', {}, { 'submission_id': @job.job_id }), 'Delete submission'

			widget (require('views.ssr.job_result')(@job))

			div class: 'header-line', ->
				div -> text "#{@job.lang\upper!} code"

			pre { id: 'code-editor', 'data-lang': 'c_cpp', 'data-readonly': 'true' }, -> text @job.code

