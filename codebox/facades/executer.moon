config = (require 'lapis.config').get!
http = require 'lapis.nginx.http'

import from_json, to_json from require 'lapis.util'
import format_date from require 'lapis.db'
import Jobs from require 'models'

class ExecuterFacade
	request: (lang, code, problem_id, test_cases, time_limit) =>
		body = http.simple "#{config.executer_addr}/request", {
			:lang
			:code
			:time_limit
			test_cases: to_json test_cases
		}

		-- Maybe add error checking?

		job_id = from_json(body).id

		job = Jobs\create {
			job_id: job_id
			user_id: 1
			problem_id: problem_id
			status: Jobs.statuses\for_db 'queued'
			lang: lang
			code: code
			time_initiated: format_date!
		}

		job_id

