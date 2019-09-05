import make_controller from require "controllers.controller"
import Jobs from require 'models'
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, yield_error from require 'lapis.application'

make_controller
	middleware: { 'internal_request' }

	post: capture_errors (=>
		assert_valid @params, {
			{ 'job_id', exists: true }
			{ 'status', exists: true }
		}

		job = Jobs\find job_id: @params.job_id
		unless job
			yield_error 'Job not found'
			return

		status = from_json @params.status

		job\update {
			status: status.status
			data: to_json status.data
		}
	
		print "Updated job: #{job.id}"
		json: { status: 'success' }
	), =>
		json: { status: 'error', errors: @errors }
