import make_controller from require "controllers.controller"
import from_json, to_json from require 'lapis.util'
import assert_valid from require 'lapis.validate'
import capture_errors, yield_error from require 'lapis.application'
import Competitions from require 'models'

make_controller
	middleware: { 'logged_in' }

    get: =>
    	@current_comp = Competitions\find active: true
    	@problems = @current_comp\get_problems!

    	render: true
