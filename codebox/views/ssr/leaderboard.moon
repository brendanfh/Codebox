html = require 'lapis.html'
import CompetitionProblems, LeaderboardProblems from require 'models'

class Leaderboard extends html.Widget
    new: (@placements) =>

    content: =>
        div class: 'leaderboard', ->
            drawn_labels = false
            for place in *@placements
                @problems = place\get_problems!
                CompetitionProblems\include_in @problems, "problem_id",
                    as: 'cp'
                    flip: true
                    local_key: 'problem_id'
                    where: { competition_id: @competition.id }
                 -- Sort the problems by letter
                prob.lnum = (prob.cp.letter\byte 1) for prob in *@problems

                table.sort @problems, (a, b) ->
                    a.lnum < b.lnum

                unless drawn_labels
                    div class: 'placement-labels', ->
                        div "Place"
                        div "Name"
                        div class: 'problem', style: "grid-template-columns: repeat(#{#@problems}, 1fr)", ->
                            for prob in *@problems
                                div "#{prob.cp.letter}"
                        div "Score"
                    drawn_labels = true

                div class: 'placement', ->
                    div "#{place.place}"
                    div "#{place\get_user!.nickname}"

                    div class: 'problem', style: "grid-template-columns: repeat(#{#@problems}, 1fr)", ->
                        for prob in *@problems
                            prob_status = switch prob.status
                                when LeaderboardProblems.statuses.correct then "correct"
                                when LeaderboardProblems.statuses.wrong then "wrong"
                                when LeaderboardProblems.statuses.attempted then "attempted"

                            div class: "#{prob_status}", ->
                                div "#{prob.points}"
                                div "#{prob.attempts}"

                    div "#{place.score}"
