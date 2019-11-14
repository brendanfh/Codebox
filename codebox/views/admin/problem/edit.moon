html = require "lapis.html"
TestCase = require "views.admin.problem.test_case"
import Problems from require 'models'

class AdminProblemEdit extends html.Widget
	content: =>
		h1 "Editing '#{@problem.name}'"

		div class: 'content', ->
			div ->
				h2 class: 'pad-l-12', 'Problem info'
				form method: 'POST', ->
					input type: 'hidden', name: 'csrf_token', value: @csrf_token
					input type: 'hidden', name: 'problem_id', value: @problem.id

					div class: 'split-2-1', ->
						div class: 'mar-r-12', ->
							label for: 'name', 'Problem name'
							input type: 'text', name: 'name', placeholder: 'Problem name', value: @problem.name, ""

						div class: 'mar-l-12', ->
							label for: 'name', 'Short name'
							input type: 'text', name: 'short_name', placeholder: 'Short URL name', value: @problem.short_name, ""

					div class: 'split-3', ->
						div class: 'mar-r-12', ->
							label for: 'name', 'Time limit'
							input type: 'number', value: 500, name: 'time_limit', value: @problem.time_limit, ""

                        div class: 'mar-l-12 mar-r-12', ->
                            label for: 'kind', 'Problem kind'
                            element 'select', name: 'kind', ->
                                option { value: 'code', selected: @problem.kind == Problems.kinds.code }, 'Programming'
                                option { value: 'golf', selected: @problem.kind == Problems.kinds.golf }, 'Code Golf'
                                option { value: 'word', selected: @problem.kind == Problems.kinds.word }, 'Word'

						div class: 'mar-l-12', ->
							label for: 'blacklisted_langs', 'Language blacklist (comma separated)'
							input type: 'text', name: 'blacklisted_langs', value: @problem.blacklisted_langs, ""

					div class: 'option-line', ->
						div 'Problem description'
						span class: 'button-list', ->
							a href: (@url_for "admin.problem.preview", { problem_name: @problem.short_name }), "Preview"

					pre { style: 'height: 32rem;', id: 'code-editor', 'data-lang': 'markdown' }, @problem.description

					input class: 'mar-t-24', type: 'submit', value: 'Update problem info'

			div class: 'mar-t-24', ->
				h2 class: 'pad-l-12', 'Test cases'

				div class: 'test-cases', ->
					for test_case in *@test_cases
						widget (TestCase test_case.testcase_order, test_case.uuid, test_case.input, test_case.output)

				button { 'data-new-tc': @problem.short_name }, 'New test case'
				button { 'data-tc-save-all': true }, 'Save all'
