db = require 'lapis.db'
import Jobs from require 'models'

has_correct_submission = (user_id, problem_name) ->
    count = db.select "count(jobs.id) from jobs
        inner join problems on problems.id = jobs.problem_id
        inner join competitions on jobs.competition_id=competitions.id
        where competitions.active=TRUE and jobs.status=? and jobs.user_id=? and problems.short_name=?
        ", (Jobs.statuses\for_db 'correct'), user_id, problem_name

    return count[1].count > 0

count_incorrect_submission = (user_id, problem_name) ->
    count = db.select "count(jobs.id) from jobs
        inner join problems on problems.id = jobs.problem_id
        inner join competitions on jobs.competition_id=competitions.id
        where competitions.active=TRUE and jobs.status in ? and jobs.user_id=? and problems.short_name=?
        ",
        (db.list {
            Jobs.statuses\for_db 'wrong_answer'
            Jobs.statuses\for_db 'timed_out'
            Jobs.statuses\for_db 'error'
            Jobs.statuses\for_db 'compile_err'
        }), user_id, problem_name

    return count[1].count

has_incorrect_submission = (user_id, problem_name) ->
    count_incorrect_submission(user_id, problem_name) > 0

get_jobs_by_user_and_problem_and_competition = (user_id, problem_id, competition_id) ->
    db.select "* from jobs where user_id=? and problem_id=? and competition_id=? order by time_initiated desc", user_id, problem_id, competition_id

get_first_correct_submission = (user_id, problem_id, competition_id) ->
    jobs = db.select "* from jobs where user_id=? and problem_id=? and competition_id=? order by time_initiated asc limit 1", user_id, problem_id, competition_id
    jobs[1]

delete_leaderboard_for_competition = (competition_id) ->
    db.query "delete from leaderboard_problems
        where leaderboard_placement_id in
            (select id from leaderboard_placements where competition_id=?)", competition_id

    db.delete "leaderboard_placements", competition_id: competition_id

get_user_score = (user_id, competition_id) ->
    res = db.select "sum(points)
        from leaderboard_problems
        inner join leaderboard_placements on leaderboard_placements.id=leaderboard_problems.leaderboard_placement_id
        where leaderboard_placements.user_id=? and competition_id=?", user_id, competition_id

    return 0 if #res == 0
    res[1].sum

get_codegolf_leaders = (problem_id, competition_id) ->
    db.select "user_id, problem_id, competition_id, status, time_initiated, char_length(code) as bytes
        from jobs
        where problem_id=? and competition_id=?
        order by status asc, bytes asc, time_initiated asc", problem_id, competition_id

clear_codegolf_scores = (problem_id, competition_id) ->
    db.query "update leaderboard_problems
        set points=0, status=1
        from leaderboard_placements
        where problem_id=? and leaderboard_placements.competition_id=?", problem_id, competition_id

-> {
    :has_correct_submission
    :count_incorrect_submission
    :has_incorrect_submission
    :get_jobs_by_user_and_problem_and_competition
    :get_first_correct_submission
    :delete_leaderboard_for_competition
    :get_user_score
    :get_codegolf_leaders
    :clear_codegolf_scores
}
