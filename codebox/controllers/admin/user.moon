import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors from require 'lapis.application'
import Users from require 'models'

make_controller
	layout: require 'views.partials.admin_layout'
	scripts: { 'admin_user' }

	middleware: { 'logged_in', 'admin_required' }

	get: =>
		@navbar.selected = 0

		@users = Users\select!

		render: 'admin.user'


