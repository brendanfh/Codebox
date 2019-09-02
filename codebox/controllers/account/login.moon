import make_controller from require "controllers.controller"
import Users from require 'models'
import assert_valid from require "lapis.validate"
import capture_errors, yield_error from require "lapis.application"

utils = require "lapis.util"

make_controller
	inject:
		crypto: 'crypto'

	middleware: { 'logged_out' }

	get: =>
		@flow 'csrf_setup'
		render: 'account.login'

	post: capture_errors =>
		@flow 'csrf_validate'

		assert_valid @params, {
			{ "username", exists: true, min_length: 2 }
			{ "password", exists: true, min_length: 2 }
		}

		user = Users\find username: @params.username
		if user != nil
			if @crypto.verify @params.password, user.password_hash
				@session.user_id = user.id
				return redirect_to: @url_for 'index'
			else
				yield_error "Password incorrect"
		else
			yield_error "User not found"

		render: 'account.login'


