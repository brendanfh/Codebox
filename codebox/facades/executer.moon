config = (require 'lapis.config').get!
http = require 'lapis.nginx.http'

import from_json, to_json from require 'lapis.util'
import Jobs from require 'models'

class ExecuterFacade
	request: (lang, code, user_id, problem_id, competition_id, test_cases, time_limit) =>
		body = http.simple "#{config.executer_addr}/request", {
			:lang
			:code
			:time_limit
			test_cases: to_json test_cases
		}

		-- Maybe add error checking?

		job_id = from_json(body).id

		Jobs\create {
			job_id: job_id
			user_id: user_id
			problem_id: problem_id
			competition_id: competition_id
			status: Jobs.statuses\for_db 'queued'
			lang: lang
			code: code
			time_initiated: os.time!
		}

		job_id

	rescore: =>
		res = http.simple "#{config.executer_addr}/rescore"
		return res
