submission_id = (new URLSearchParams window.location.search).get 'submission_id'
competition_name = (window.location.pathname.split '/')[1]

updateStatus = ->
    $.get "/#{competition_name}/submissions/status", { submission_id: submission_id }, (html, _, data) ->
        $('#status-container').html html

$(document).ready ->
	socket = io()
	socket.emit "request-submission-updates", submission_id

	socket.on 'update', ->
		updateStatus()
