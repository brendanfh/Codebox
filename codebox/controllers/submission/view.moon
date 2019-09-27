import make_controller from require "controllers.controller"
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions, Jobs from require 'models'

make_controller
	middleware: { 'logged_in' }
    scripts: { 'vendor/ace/ace', 'submission_reloader' }
	raw_scripts: { '/socket.io/socket.io.js' }

    get: capture_errors_json =>
		@navbar.selected = 2

        assert_valid @params, {
            { "submission_id", exists: true }
        }

        @job = Jobs\find job_id: @params.submission_id
        unless @job.user_id == @user.id
            yield_error "You are not allowed to view this submission!"

    	render: 'submission.view'
