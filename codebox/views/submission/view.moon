html = require 'lapis.html'

class SubmissionView extends html.Widget
    content: =>
        div class: 'content', ->
            div id: 'status-container', ->
                widget (require('views.ssr.job_result')(@job))

			div class: 'header-line', ->
				div -> text "#{@job.lang\upper!} code"

			pre { id: 'code-editor', 'data-lang': 'c_cpp', 'data-readonly': 'true' }, -> text @job.code