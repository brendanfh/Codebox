import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions, Problems, CompetitionProblems from require 'models'

make_controller
    inject:
        scoring: 'scoring'

	middleware: { 'logged_in', 'admin_required' }

	post: capture_errors_json =>
        assert_valid @params, {
            { "competition_id", exists: true, is_integer: true }
            { "problem_name", exists: true }
            { "letter", exists: true }
        }

        comp = Competitions\find @params.competition_id
        unless comp
            yield_error 'Competition not found'
            return

        problem = Problems\find short_name: @params.problem_name
        unless problem
            yield_error 'Problem not found'
            return

        comp_prob = CompetitionProblems\select "where competition_id=? and problem_id=?", @params.competition_id, problem.id
        if #comp_prob > 0
            yield_error 'Problem already in competition'
            return

        CompetitionProblems\create {
            competition_id: @params.competition_id
            problem_id: problem.id
            letter: @params.letter
        }

        @scoring\rescore_everything!

		redirect_to: @url_for 'admin.competition.edit', { competition_id: @params.competition_id }
