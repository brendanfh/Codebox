import make_controller from require "controllers.controller"
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, yield_error from require 'lapis.application'
import Competitions, Jobs from require 'models'

make_controller
	inject:
		queries: 'queries'

	middleware: { 'logged_in' }

    get: =>
		@navbar.selected = 2

    	render: 'submission.list'