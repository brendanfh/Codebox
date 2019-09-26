html = require 'lapis.html'
import Jobs from require 'models'

class SubmissionList extends html.Widget
    content: =>
        h1 "Submissions"

        div class: 'content', ->
            for prob in *@problems
                div class: 'header-line', -> div prob.name
                div class: 'box', ->
                    jobs = @queries.get_jobs_by_user_and_problem_and_competition @user.id, prob.id, @competition.id
                    if #jobs == 0
                        div class: 'pad-12', "No submissions to this problem."
                        return

                    div class: 'split-4-1', ->
                        div ->
                            for job in *jobs
                                tab_color = job.status == Jobs.statuses.correct and 'success' or 'error'
                                a href: (@url_for 'submission.view', {}, { submission_id: job.job_id }), ->
                                    div class: "highlight tabbed-split tab-24 #{tab_color}", ->
                                        span ""
                                        div class: 'pad-12 split-4', ->
                                            div Jobs.statuses\to_name job.status
                                            div job.lang\upper!
                                            div "Bytes: #{job.bytes}"
                                            div (os.date '%c', job.time_initiated)

                        correct = 0
                        wrong = 0
                        timed_out = 0
                        error = 0

                        for job in *jobs
                            switch job.status
                                when Jobs.statuses.correct then correct += 1
                                when Jobs.statuses.wrong_answer then wrong += 1
                                when Jobs.statuses.timed_out then timed_out += 1
                                when Jobs.statuses.error then error += 1
                                when Jobs.statuses.compile_err then error += 1

                        if (correct + wrong + timed_out + error) > 0
                            piechart {
                                style: 'display: inline-block; text-align: center; width: 100%',
                                class: "highlight pad-12",
                                "data-size": 200,
                                "data-segments": 4,
                                "data-segment-1": correct,
                                "data-segment-1-color": "#44ff44",
                                "data-segment-2": wrong,
                                "data-segment-2-color": "#ff4444",
                                "data-segment-3": timed_out,
                                "data-segment-3-color": "#4444ff",
                                "data-segment-4": error,
                                "data-segment-4-color": "#777777"
                            }, ""
