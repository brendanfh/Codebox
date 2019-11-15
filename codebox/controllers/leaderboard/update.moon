import make_controller from require "controllers.controller"
Leaderboard = require 'views.ssr.leaderboard'

make_controller
    layout: false
    middleware: { 'logged_in', 'competition_started', 'competition_active' }

    get: =>
        @placements = @competition\get_leaderboard!

        leaderboard_widget = Leaderboard @placements
        leaderboard_widget\include_helper @
        return { layout: false, status_code: 200, leaderboard_widget\render_to_string! }
