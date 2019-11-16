start_time = 0
end_time = 0

$time_left = null
$progress_meter = null
duration = 0

competition_name = (window.location.pathname.split '/')[1]

updateLeaderboard = ->
	$.get "/#{competition_name}/leaderboard/update", {}, (html, _, data) ->
		$('#leaderboard-container').html html

updateTime = ->
	curr_time = Date.now()

	time_elapsed = curr_time - start_time
	percent = time_elapsed / duration
	if percent > 1 then percent = 1
	$progress_meter.css 'width', "#{percent * 100}%"

	time_left = end_time - curr_time
	if time_left < 0
		$time_left.html "Competition is over"
		return

	hours = Math.floor(time_left / (1000 * 60 * 60))
	minutes = Math.floor(time_left / (1000 * 60)) - hours * 60
	seconds = Math.floor(time_left / 1000) - hours * 60 * 60 - minutes * 60

	msg = ""
	if hours > 0 then msg += "#{hours} hour#{if hours != 1 then "s" else ""}, "
	if minutes > 0 or hours > 0 then msg += "#{minutes} minute#{if minutes != 1 then "s" else ""}, "
	msg += "#{seconds} second#{if seconds != 1 then "s" else ""} left"

	$time_left.html msg

	setTimeout updateTime, 1000

$(document).ready ->
	socket = io()
	socket.emit "request-leaderboard-updates"

	$time_left = $ '#time-left'
	$progress_meter = $ '#progress-meter'

	comp_info = $ '#comp-info'
	start_time = (comp_info.attr 'data-start') * 1000
	end_time = (comp_info.attr 'data-end') * 1000
	duration = end_time - start_time

	setTimeout updateTime, 0

	socket.on 'update', ->
		updateLeaderboard()
