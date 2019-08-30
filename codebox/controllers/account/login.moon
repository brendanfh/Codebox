import make_controller from require "controllers.controller"
import Users from require 'models'
import assert_valid from require "lapis.validate"

utils = require "lapis.util"

make_controller
	inject:
		crypto: 'crypto'

	middleware: { 'logged_out' }

	get: =>
		@flow 'csrf_setup'
		render: 'account.login'

	post: =>
		@flow 'csrf_validate'

		assert_valid @params, {
			{ "username", exists: true, min_length: 2 }
			{ "password", exists: true, min_length: 2 }
		}

		users = Users\find username: @params.username
		if #users > 0
			if @crypto.verify @params.password, users[1].password_hash
				@session.user_id = users[1].id
				return redirect_to: @url_for 'index'

		render: 'account.login'


