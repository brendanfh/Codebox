import make_controller from require "controllers.controller"

import Users, Jobs from require 'models'

make_controller
	middleware: { 'logged_in' }

	get: =>
		@users = Users\select!
		@jobs = @user\get_c_jobs!
		render: "index"
