import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors from require 'lapis.application'
import Problems from require 'models'

make_controller
	layout: require 'views.partials.admin_layout'

	middleware: { 'logged_in', 'admin_required' }

	get: =>
		@navbar.selected = 1

		@problems = Problems\select!

		render: 'admin.problem'


