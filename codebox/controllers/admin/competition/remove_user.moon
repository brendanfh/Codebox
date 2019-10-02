import make_controller from require "controllers.controller"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import assert_valid from require 'lapis.validate'
import CompetitionUsers from require 'models'

make_controller
	inject:
		executer: 'executer'

	middleware: { 'logged_in', 'admin_required' }

	get: capture_errors_json =>
		assert_valid @params, {
			{ "competition_id", exists: true, is_integer: true }
			{ "user_id", exists: true, is_integer: true }
		}

		comp_user = CompetitionUsers\find
			competition_id: @params.competition_id
			user_id: @params.user_id

		if comp_user
			comp_user\delete!

			@executer\rescore!
        	return redirect_to: @url_for "admin.competition.edit", { competition_id: @params.competition_id }
		else
			yield_error "Compeition user not found"

