save_testcase = (test_case_id) ->
	input = $("[data-tc-input-id=\"#{test_case_id}\"]").val()
	output = $("[data-tc-output-id=\"#{test_case_id}\"]").val()
	order = $("[data-tc-order-id=\"#{test_case_id}\"]").val()

	$.post '/admin/testcases/edit', {
		"test_case_id": test_case_id,
		"input": input || "",
		"output": output || "",
		"order": order,
	}, (data) ->
		console.log data

setup_handlers = ->
	$('[data-tc-save-all]').click ->
		elements = $('[data-tc-save]')
		elements.each (k, e) ->
			test_case_id = $(e).attr 'data-tc-save'
			save_testcase test_case_id

		alert 'Saved all test cases'
		window.location.reload()

	$('[data-tc-save]').click (e) ->
		test_case_id = $(e.target).attr 'data-tc-save'
		save_testcase test_case_id
		alert 'Saved test case'
		window.location.reload()

	$('[data-tc-delete]').click (e) ->
		test_case_id = $(e.target).attr 'data-tc-delete'
		$.post '/admin/testcases/delete', { "test_case_id": test_case_id }, (data) ->
			$("[data-testcase=\"#{test_case_id}\"]").remove()
			console.log data

	$('[data-new-tc]').click (e) ->
		problem_name = $(e.target).attr 'data-new-tc'
		$.post '/admin/testcases/new', { short_name: problem_name }, (data) ->
			console.log data
			$('.test-cases').after data.html

	$('[data-problem-delete]').click (e) ->
		if not confirm 'Are you sure you want to delete this problem?'
			return
		problem_name = $(e.target).attr 'data-problem-delete'

		$.post '/admin/problems/delete', { short_name: problem_name }, (data) ->
			alert "Deleted #{problem_name}."
			window.location.reload()

$(document).ready ->
	setup_handlers()

