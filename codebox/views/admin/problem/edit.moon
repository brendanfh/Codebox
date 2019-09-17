html = require "lapis.html"
TestCase = require "views.admin.problem.test_case"

class AdminProblemEdit extends html.Widget
	content: =>
		h1 "Editing '#{@problem.name}'"

		div class: 'content', ->
			div ->
				h2 class: 'pad-l-12', 'Problem info'
				form method: 'POST', ->
					input type: 'hidden', name: 'csrf_token', value: @csrf_token
					input type: 'hidden', name: 'problem_id', value: @problem.id

					label for: 'name', 'Problem name'
					input type: 'text', name: 'name', placeholder: 'Problem name', value: @problem.name, ""

					div class: 'split-2', ->
						div ->
							label for: 'name', 'Short name'
							input type: 'text', name: 'short_name', placeholder: 'Short URL name', value: @problem.short_name, ""

						div ->
							label for: 'name', 'Time limit'
							input type: 'number', value: 500, name: 'time_limit', value: @problem.time_limit, ""

					div class: 'header-line', -> div 'Problem description'
					pre { style: 'height: 32rem;', id: 'code-editor', 'data-lang': 'markdown' }, @problem.description

					input class: 'mar-t-24', type: 'submit', value: 'Update problem info'

			div class: 'mar-t-24', ->
				h2 class: 'pad-l-12', 'Test cases' 

				div class: 'test-cases', ->
					for test_case in *@test_cases
						widget (TestCase test_case.testcase_order, test_case.uuid, test_case.input, test_case.output)

				button { 'data-new-tc': @problem.short_name }, 'New test case'
				button { 'data-tc-save-all': true }, 'Save all'
	