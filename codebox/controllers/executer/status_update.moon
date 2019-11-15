import make_controller from require "controllers.controller"
import Jobs, Problems from require 'models'
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, yield_error from require 'lapis.application'

make_controller
    inject:
        scoring: 'scoring'
		updater: 'updater'

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

        if status.status != Jobs.statuses.running
			@scoring\initialize job.competition_id
            @scoring\score job.user_id, job.problem_id
            @scoring\place!

		@updater\push_submission_update job.job_id

		json: { status: 'success' }
	), =>
		print "Hit error in post of status_update #{@errors}"
		json: { status: 'error', errors: @errors }
