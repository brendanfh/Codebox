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