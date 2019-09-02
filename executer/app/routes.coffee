request = require 'request'
uuid = require 'uuid/v4'

executer = new (require './executer').Executer()

# Apparent Coffeescript can't handle a for await
# loop so this is written in plain javascript
```
async function handle_job(job_id, lang, code, cases, time_limit) {
	let processor = executer.process(lang, code, cases, time_limit)

	for await (let status of processor) {
		request.post('http://192.168.0.3:8888/executer/status_update',
			{ json: true,
			  form: {
			  	  request_token: process.env.REQ_SECRET,
				  job_id: job_id,
				  status: JSON.stringify(status)
			  }
			},
			(err, res, body) => {
				if (err) {
					return console.log(err)
				}

				console.log("Updated job: ", job_id, status.status)
			}
		)
	}
}
```

module.exports = (app) ->
	app.get '/', (req, res) ->
		res.json {
			test: 'This is test data'
		}

	app.post '/request', (req, res) ->
		cases = JSON.parse req.body.test_cases
		job_id = uuid()

		handle_job job_id, req.body.lang, req.body.code, cases, req.body.time_limit

		res.json {
			id: job_id
		}
