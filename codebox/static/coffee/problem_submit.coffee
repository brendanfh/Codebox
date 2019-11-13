$(document).ready ->
    $("#language").change (ev) ->
        $lang = $(ev.target).val()

        editor_lang = switch $lang
            when 'c' then 'c_cpp'
            when 'cpp' then 'c_cpp'
            when 'py' then 'python'
            when 'lua' then 'lua'

        editor = ace.edit 'code-editor'
        editor.session.setMode "ace/mode/#{editor_lang}"

    $('#submit-btn').click ->
        lang = $('#language').val()
        code = (ace.edit 'code-editor').getValue()

        $.post window.location.pathname, {
            lang: lang,
            code: code
        }, (data) ->
            window.location.replace("/submissions/view?submission_id=#{data}")

    $('#word-problem-submit-btn').click ->
        answer = $('#answer').val()

        $.post window.location.pathname, {
            answer: answer
        }, (data) ->
            setTimeout 1000, window.location.reload
