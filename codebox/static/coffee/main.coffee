$(document).ready ->
	$('#code-editor').each (_, v) ->
		editor = ace.edit 'code-editor'

		editor.setTheme 'ace/theme/chaos'
		editor.setShowPrintMargin false
		editor.setFontSize 16

		$v = $ v
		if $v.attr 'data-lang'
			editor.session.setMode "ace/mode/#{$v.attr 'data-lang'}"

		if $v.attr 'data-readonly'
			editor.setReadOnly true

	$('[data-setonload]').each (_, el) ->
		$el = $ el
		data = $el.attr 'data-setonload'
		changes = data.split ','

		for change from changes
			change.trim()
			prop_val = (change.split ':').map((x) -> x.trim())

			$el.css prop_val[0], prop_val[1]

		return

