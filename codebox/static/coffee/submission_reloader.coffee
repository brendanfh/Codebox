submission_id = (new URLSearchParams window.location.search).get 'submission_id'

updateStatus = ->
    $.get '/submissions/status', { submission_id: submission_id }, (html, _, data) ->
        $('#status-container').html html

        if data.status == 200
            setTimeout updateStatus, 100

$(document).ready ->
    updateStatus()