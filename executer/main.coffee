http = require 'http'
express = require 'express'
morgan = require 'morgan'
bodyParser = require 'body-parser'

app = express()
app.use (morgan 'dev')
app.use bodyParser.urlencoded { extended: true }

routes = require './app/routes'
routes(app)

server = http.createServer(app)
server.listen 8080, ->
	console.log 'Started http server on port 8080'
