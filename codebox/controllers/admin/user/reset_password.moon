import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json from require 'lapis.application'
import Users from require 'models'

make_controller
	inject:
		crypto: 'crypto'

	middleware: { 'logged_in', 'admin_required' }

	post: capture_errors_json =>
		assert_valid @params, {
			{ "username", exists: true }
			{ "password", exists: true }
		}

		user = Users\find username: @params.username
		unless user
			yield_error "User not found"

		user\update {
			password_hash: @crypto.encrypt @params.password
		}

		json: { success: true }

