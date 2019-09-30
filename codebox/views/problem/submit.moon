html = require 'lapis.html'
require 'utils.string'

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

							blacklisted = string.split @problem.blacklisted_langs, ','
                            element 'select', id: 'language', ->
								unless table.contains blacklisted, 'c'
									option value: 'c', -> text 'C'
								unless table.contains blacklisted, 'cpp'
									option value: 'cpp', -> text 'C++'
								unless table.contains blacklisted, 'py'
									option value: 'py', -> text 'Python 3'
								unless table.contains blacklisted, 'lua'
									option value: 'lua', -> text 'Lua'
                        div class: 'button-list', ->
                            button id: 'submit-btn', -> text "Submit"

                    pre { style: 'height: 40rem', id: 'code-editor', 'data-lang': 'c_cpp' }, ""
