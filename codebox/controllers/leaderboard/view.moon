import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import LeaderboardProblems, LeaderboardPlacements from require 'models'

make_controller
    middleware: { 'logged_in', 'competition_started' }

    get: =>
        @navbar.selected = 0

        @placements = @competition\get_leaderboard!

        render: 'leaderboard.view'
