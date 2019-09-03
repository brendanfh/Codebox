html = require "lapis.html"
TestCase = require "views.admin.problem.test_case"

class AdminProblemEdit extends html.Widget
	content: =>
		h1 "Editing '#{@problem.name}'"

		div class: 'content', ->
			form method: 'POST', ->
				input type: 'hidden', name: 'csrf_token', value: @csrf_token
				input type: 'hidden', name: 'problem_id', value: @problem.id

				label for: 'name', 'Problem name'
				input type: 'text', name: 'name', placeholder: 'Problem name', value: @problem.name, ""

				label for: 'name', 'Short name'
				input type: 'text', name: 'short_name', placeholder: 'Short URL name', value: @problem.short_name, ""

				label for: 'name', 'Problem description'
				textarea name: 'description', placeholder: 'Problem description', @problem.description

				label for: 'name', 'Time limit'
				input type: 'number', value: 500, name: 'time_limit', value: @problem.time_limit, ""

				input type: 'submit', value: 'Update problem'

			h2 style: 'margin: 48px 0 16px; padding-left: 12px', 'Test cases'

			div class: 'test-cases', ->
				for test_case in *@test_cases
					widget (TestCase test_case.testcase_order, test_case.uuid, test_case.input, test_case.output)

			button { 'data-new-tc': @problem.short_name }, 'New test case'
			button { 'data-tc-save-all': true }, 'Save all'
