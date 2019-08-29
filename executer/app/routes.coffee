request = require 'request'

module.exports = (app) ->
	app.get '/', (req, res) ->
		res.json {
			test: 'This is test data'
		}

	app.post '/submit', (req, res) ->
		console.log req.body.lang, req.body.code

		request.post 'http://192.168.0.3:8888/executer/status_update',
			{ json: true, form: { request_token: process.env.REQ_SECRET } },
			(err, res, body) ->
				if err
					return console.log err

				console.log body.status

		res.json {
			id: 'test'
		}
