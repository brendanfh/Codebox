html = require "lapis.html"

class TestCase extends html.Widget
	new: (order, id, input, output) =>
		@order = order
		@id = id
		@input = input
		@output = output

	content: =>
		div { 'data-testcase': @id }, ->
			div class: 'option-line', ->
				div ->
					span "Case  "
					input { type: "number", min: 0, max: 1000, value: @order, 'data-tc-order-id': @id }, ''
				div class: 'button-list', ->
					button { 'data-tc-save': @id }, 'Save'
					button { 'data-tc-delete': @id }, 'Delete'

			div style: 'margin-bottom: 12px', class: 'split', ->
				textarea { class: 'test_case', 'data-tc-input-id': @id }, @input
				textarea { class: 'test_case', 'data-tc-output-id': @id }, @output
