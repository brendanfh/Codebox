import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Jobs from require 'models'

make_controller
	layout: require "views.partials.admin_layout"

	middleware: { 'logged_in', 'admin_required' }

	get: capture_errors_json =>
		assert_valid @params, {
			{ 'submission_id', exists: true }
		}

		job = Jobs\find job_id: @params.submission_id
		unless job
			yield_error 'Job not found'

		job\delete!

		redirect_to: @url_for 'admin.submission'
