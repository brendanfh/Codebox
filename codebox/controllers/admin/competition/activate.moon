import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions, Problems, CompetitionProblems from require 'models'
db = require 'lapis.db'

make_controller
	middleware: { 'logged_in', 'admin_required' }

	get: capture_errors_json =>
        assert_valid @params, {
            { "competition_id", exists: true }
        }

        comp = Competitions\find @params.competition_id
        unless comp
            yield_error "Competition not found"

        db.query 'UPDATE competitions SET active=FALSE WHERE 1=1;'

        comp\update {
            active: true
        }

        redirect_to: @url_for "admin.competition"