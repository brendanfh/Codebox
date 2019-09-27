updateLeaderboard = ->
	$.get '/leaderboard/update', {}, (html, _, data) ->
		$('#leaderboard-container').html html

$(document).ready ->
	socket = io()
	socket.emit "request-leaderboard-updates"

	socket.on 'update', ->
		updateLeaderboard()
