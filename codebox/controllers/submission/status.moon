import make_controller from require "controllers.controller"
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions, Jobs from require 'models'
JobResult = require 'views.ssr.job_result'

make_controller
    layout: false
	middleware: { 'logged_in' }

    get: capture_errors_json =>
		@navbar.selected = 2

        assert_valid @params, {
            { "submission_id", exists: true }
        }

        @job = Jobs\find job_id: @params.submission_id
        unless @job.user_id == @user.id
            yield_error "You are not allowed to view this submission!"

        status_code = 201
        switch @job.status
            when Jobs.statuses.queued then status_code = 200
			when Jobs.statuses.compiling then status_code = 200
            when Jobs.statuses.running then status_code = 200

        status_widget = JobResult @job
        return { layout: false, status: status_code, status_widget\render_to_string! }