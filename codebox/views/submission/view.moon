html = require 'lapis.html'

class SubmissionView extends html.Widget
    content: =>
        div class: 'content', ->
            div id: 'status-container', ->
                widget (require('views.ssr.job_result')(@job))

			div class: 'header-line', ->
				div -> text "#{@job.lang\upper!} code"

            lang = ''
            switch @job.lang
                when 'c' then lang = 'c_cpp'
                when 'cpp' then lang = 'c_cpp'
                when 'py' then lang = 'python'
                when 'lua' then lang = 'lua'

			pre { id: 'code-editor', 'data-lang': lang, 'data-readonly': 'true' }, -> text @job.code