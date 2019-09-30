import Model from require "lapis.db.model"
db = require 'lapis.db'
import Jobs from require 'models'

class Users extends Model
	@relations: {
		{ 'jobs', has_many: 'Jobs' }
		{ 'current_jobs', fetch: =>
			db.select "jobs.job_id, jobs.problem_id, jobs.lang, jobs.code, jobs.status, jobs.data, jobs.time_initiated from jobs
			inner join competition_problems on competition_problems.problem_id = jobs.problem_id
			inner join competitions on competitions.id = competition_problems.competition_id
			where competitions.active=? and jobs.user_id=?", db.TRUE, @id
		}
		{ "competitions", has_many: "CompetitionUsers" }
	}

	@has_correct_submission: (user_id, problem_name) =>
		count = db.select "count(jobs.id) from jobs
			inner join problems on problems.id = jobs.problem_id
			inner join competitions on jobs.competition_id=competitions.id
			where competitions.active=TRUE and jobs.status=? and jobs.user_id=? and problems.short_name=?
			", (Jobs.statuses\for_db 'correct'), user_id, problem_name

		return count[1].count > 0

	@count_incorrect_submission: (user_id, problem_name) =>
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

	@has_incorrect_submission: (user_id, problem_name) =>
		(@@count_incorrect_submission user_id, problem_name) > 0

	@get_score: (user_id, competition_id) =>
		res = db.select "sum(points)
			from leaderboard_problems
			inner join leaderboard_placements on leaderboard_placements.id=leaderboard_problems.leaderboard_placement_id
			where leaderboard_placements.user_id=? and competition_id=?", user_id, competition_id

		return 0 if #res == 0
		res[1].sum

	@get_first_correct_submission: (user_id, problem_id, competition_id) =>
		jobs = db.select "* from jobs where user_id=? and problem_id=? and competition_id=? order by time_initiated asc limit 1", user_id, problem_id, competition_id
		jobs[1]

	@get_jobs_by_problem: (user_id, problem_id, competition_id) =>
		db.select "* from jobs where user_id=? and problem_id=? and competition_id=? order by time_initiated desc", user_id, problem_id, competition_id
