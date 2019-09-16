html = require 'lapis.html'

class ProblemSubmit extends html.Widget
    content: =>
		div class: 'sidebar-page-container', ->
			div class: 'sidebar-problem-list', ->
				widget (require 'views.partials.problem_sidebar')

			div class: 'content', ->
                h1 "Submit to '#{@problem.name}'"

                div class: 'header-line', -> div "Code Editor"
                div class: 'box', ->
                    div class: 'split-lr', ->
                        div class: 'mar-l-12', ->
                            span -> text "Language: "
                            element 'select', id: 'language', ->
                                option value: 'c', -> text 'C'
                                option value: 'cpp', -> text 'C++'
                                option value: 'py', -> text 'Python'
                                option value: 'lua', -> text 'Lua'
                        div class: 'button-list', ->
                            button id: 'submit-btn', -> text "Submit"

                    pre { style: 'height: 40rem', id: 'code-editor', 'data-lang': 'c_cpp' }, ""