import make_controller from require "controllers.controller"
import Competitions from require "models"

make_controller
    inject:
        scoring: 'scoring'

    middleware: { 'logged_in', 'admin_required' }

    get: =>
		@scoring\rescore_everything!

        return json: 'Scored all users'
