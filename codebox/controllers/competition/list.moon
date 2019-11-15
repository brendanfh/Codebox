import make_controller from require "controllers.controller"
import capture_errors_json, yield_error from require 'lapis.application'
import assert_valid from require "lapis.validate"
import Competitions from require 'models'

make_controller
    middleware: { 'logged_in' }

    get: capture_errors_json =>
		@competitions = Competitions\select "where active = ?", true

		render: 'competition.list'
