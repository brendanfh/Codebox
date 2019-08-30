config = require "lapis.config"

config "development", ->
	port 8888

	secret (os.getenv 'APP_SECRET')
	req_secret (os.getenv 'REQ_SECRET')

	executer_addr 'http://192.168.0.4:8080'

	postgres ->
		-- Have to use a fixed ip since the container name
		-- was not resolving correctly
		host "192.168.0.2"
		database (os.getenv 'POSTGRES_DB')
		user (os.getenv 'POSTGRES_USER')
		password (os.getenv 'POSTGRES_PASSWORD')
