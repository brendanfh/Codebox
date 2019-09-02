import make_controller from require "controllers.controller"
import Users from require 'models'
import assert_valid from require "lapis.validate"
import capture_errors, yield_error from require 'lapis.application'

make_controller
	inject:
		crypto: 'crypto'

	middleware: { 'logged_out' }

	get: =>
		@flow 'csrf_validate'
		render: 'account.register'

	post: capture_errors =>
		@flow 'csrf_validate'

		assert_valid @params, {
			{ "username", exists: true, min_length: 2 }
			{ "nickname", exists: true, min_length: 2 }
			{ "email", exists: true, min_length: 4, matches_pattern: "%S+@%S+%.%S+" }
			{ "password", exists: true, min_length: 2 }
			{ "password_confirmation", exists: true, min_length: 2, equals: @params.password, 'Passwords must be the same' }
		}

		users = Users\find username: @params.username
		if users
			-- Account already exists
			yield_error 'Username already taken'
			return render: 'account.register'

		user_id = Users\create {
			username: @params.username
			email: @params.email
			nickname: @params.nickname
			password_hash: @crypto.encrypt @params.password
		}

		unless user_id
			@errors or= {}
			table.insert @errors, 'Error creating account'
			return render: 'account.register'

		@session.user_id = user_id
		redirect_to: @url_for 'index'

