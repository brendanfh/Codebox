import make_controller from require "controllers.controller"
import Competitions, CompetitionUsers from require 'models'

make_controller
	inject:
		executer: 'executer'

	middleware: { 'logged_in' }

	get: =>
		@competition = Competitions\find active: true
		CompetitionUsers\create
			user_id: @user.id
			competition_id: @competition.id

		@executer\rescore!

		return redirect_to: @url_for 'index'
