import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions, Problems, CompetitionProblems from require 'models'

make_controller
	middleware: { 'logged_in', 'admin_required' }

	get: capture_errors_json =>
        assert_valid @params, {
            { "competition_id", exists: true, is_integer: true }
            { "problem_id", exists: true, is_integer: true }
        }

        comp_prob = CompetitionProblems\select "where competition_id=? and problem_id=?", @params.competition_id, @params.problem_id
        for cp in *comp_prob
            cp\delete!

        redirect_to: @url_for "admin.competition.edit", { competition_id: @params.competition_id }