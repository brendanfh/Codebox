import make_controller from require "controllers.controller"

make_controller
    inject:
        scoring: 'scoring'

    middleware: { 'logged_in', 'admin_required' }

    get: =>
        @scoring\setup_scoring_tables!
        @scoring\score_all!
        @scoring\place!

        return json: 'Scored all users'
