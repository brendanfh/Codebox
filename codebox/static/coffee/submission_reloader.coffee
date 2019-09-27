submission_id = (new URLSearchParams window.location.search).get 'submission_id'

updateStatus = ->
    $.get '/submissions/status', { submission_id: submission_id }, (html, _, data) ->
        $('#status-container').html html

$(document).ready ->
	socket = io()
	socket.emit "request-submission-updates", submission_id

	socket.on 'update', ->
		updateStatus()
