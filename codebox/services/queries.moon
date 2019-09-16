db = require 'lapis.db'
import Jobs from require 'models'

-> {
    has_correct_submission: (user_id, problem_name) ->
        count = db.select "count(problems.id) from problems
            inner join jobs on problems.id = jobs.problem_id
            where jobs.status=? and jobs.user_id=? and problems.short_name=?
            ", (Jobs.statuses\for_db 'correct'), user_id, problem_name
        
        return count[1].count > 0

    has_incorrect_submission: (user_id, problem_name) ->
        count = db.select "count(problems.id) from problems
            inner join jobs on problems.id = jobs.problem_id
            where jobs.status in ? and jobs.user_id=? and problems.short_name=?
            ",
            (db.list {
                Jobs.statuses\for_db 'wrong_answer'
                Jobs.statuses\for_db 'timed_out'
                Jobs.statuses\for_db 'error'
                Jobs.statuses\for_db 'compile_err'
            }), user_id, problem_name
        
        return count[1].count > 0

    get_jobs_by_user_and_problem: (user_id, problem_id) ->
        db.select "* from jobs where user_id=? and problem_id=? order by time_initiated desc", user_id, problem_id
}