html = require 'lapis.html'
import CompetitionProblems, LeaderboardProblems from require 'models'
Leaderboard = require 'views.ssr.leaderboard'

class LeaderboardView extends html.Widget
    content: =>
        h1 "#{@competition.name} - Leaderboard"

        div class: 'content', ->
            widget (Leaderboard @placements)
