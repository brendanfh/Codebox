import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors from require 'lapis.application'
import Jobs from require 'models'

make_controller
	layout: require 'views.partials.admin_layout'
	scripts: { 'admin_problem' }

	middleware: { 'logged_in', 'admin_required' }

	get: =>
		@navbar.selected = 2

		@jobs = Jobs\select "order by id desc"

		render: 'admin.submission'

