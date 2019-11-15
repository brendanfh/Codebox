import assert_valid from require "lapis.validate"
import make_controller from require "controllers.controller"
import Competitions, CompetitionUsers from require 'models'

make_controller
	inject:
		executer: 'executer'

	middleware: { 'logged_in' }

	get: =>
		assert_valid @params, {
			{ "competition_name", exists: true }
		}

		@competition = Competitions\find short_name: @params.competition_name
		CompetitionUsers\create
			user_id: @user.id
			competition_id: @competition.id

		@executer\rescore!

		return redirect_to: @url_for 'leaderboard', { competition_name: @competition.short_name }
