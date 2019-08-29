http = require 'lapis.nginx.http'
import from_json, to_json from require 'lapis.util'

class ExecuterFacade
	request: (lang, code) =>
		body = http.simple 'http://192.168.0.4:8080/submit', {
			lang: lang
			code: code
		}

		from_json(body).id


