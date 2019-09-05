import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions from require 'models'

make_controller
	middleware: { 'logged_in', 'admin_required' }

	get: capture_errors_json =>
        assert_valid @params, {
            { "competition_id", exists: true, is_integer: true }
        }

        comp = Competitions\find @params.competition_id
        unless comp
            yield_error 'Competition not found'

        comp_problems = comp\get_competition_problems!
        if comp_problems
            for cp in *comp_problems
                cp\delete!

        comp\delete!

		redirect_to: @url_for 'admin.competition'
