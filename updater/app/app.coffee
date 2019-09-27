express = require 'express'
app = express()
server = require('http').createServer(app)
io = require('socket.io')(server)

class UpdateForwarder
	constructor: ->
		@channels = new Map()

	add_channel: (channel_name) ->
		unless @channels.has channel_name
			@channels.set channel_name, []

	join_channel: (channel_name, socket) ->
		return unless @channels.has channel_name
		@channels.get(channel_name).push(socket)

	leave_channel: (channel_name, socket) ->
		return unless @channels.has channel_name

		sockets = @channels.get channel_name
		idx = sockets.indexOf socket
		sockets.splice idx, 1

	leave: (socket) ->
		for chan from @channels.values()
			idx = chan.indexOf socket
			if idx != -1
				chan.splice idx, 1
		return

	push_update: (channel_name, param_match="") ->
		return unless @channels.has channel_name

		for sock in @channels.get channel_name
			if param_match != ""
				if sock.param == param_match
					sock.emit 'update', {}
			else
				sock.emit 'update', {}
		return

update_forwarder = new UpdateForwarder()
update_forwarder.add_channel "submission-updates"
update_forwarder.add_channel "leaderboard-updates"

io.on 'connection', (socket) ->
	# data is the submission id
	socket.on 'request-submission-updates', (data) ->
		socket.param = data
		update_forwarder.join_channel "submission-updates", socket

	socket.on 'request-leaderboard-updates', (data) ->
		update_forwarder.join_channel "leaderboard-updates", socket

	socket.once 'disconnect', ->
		update_forwarder.leave socket

app.get '/submission_update', (req, res) ->
	submission_id = req.query.submission_id
	update_forwarder.push_update "submission-updates", submission_id

	res.status 200
	res.end()

app.get '/leaderboard_update', (req, res) ->
	update_forwarder.push_update "leaderboard-updates"

	res.status 200
	res.end()

main = ->
	port = 5000
	console.log "Socket IO server running on port #{port}"
	server.listen port

module.exports = main
