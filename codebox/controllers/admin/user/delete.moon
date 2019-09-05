import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json from require 'lapis.application'
import Users, Jobs from require 'models'

make_controller
	middleware: { 'logged_in', 'admin_required' }

	post: capture_errors_json =>
		assert_valid @params, {
			{ "username", exists: true }
		}

		user = Users\find username: @params.username
		unless user
			yield_error "User not found"

		jobs = Jobs\find user_id: user.id
		if jobs
			for job in *jobs
				job\delete!

		user\delete!

		json: { success: true }

