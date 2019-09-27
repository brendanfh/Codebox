import Model, enum from require "lapis.db.model"
db = require 'lapis.db'
import Jobs from require 'models'

class Problems extends Model
	@kinds: enum {
		code: 1
		golf: 2
		word: 3
	}

	@relations: {
		{ "jobs", has_many: 'Jobs' }
		{ "test_cases"
			has_many: 'TestCases'
			order: "testcase_order asc"
		}
		{ "competitions", has_many: "CompetitionProblems" }
		{ "correct_jobs", fetch: =>
			(db.query "select count(job_id) from jobs
			inner join competitions on jobs.competition_id = competitions.id
			where competitions.active=TRUE and jobs.problem_id=? and jobs.status=4", @id)[1].count
		}
		{ "wrong_answer_jobs", fetch: =>
			(db.query "select count(job_id) from jobs
			inner join competitions on jobs.competition_id = competitions.id
			where competitions.active=TRUE and jobs.problem_id=? and jobs.status=5", @id)[1].count
		}
		{ "timed_out_jobs", fetch: =>
			(db.query "select count(job_id) from jobs
			inner join competitions on jobs.competition_id = competitions.id
			where competitions.active=TRUE and jobs.problem_id=? and jobs.status=6", @id)[1].count
		}
		{ "error_jobs", fetch: =>
			(db.query "select count(job_id) from jobs
			inner join competitions on jobs.competition_id = competitions.id
			where competitions.active=TRUE and jobs.problem_id=? and jobs.status in ?", @id,
				db.list {
					Jobs.statuses\for_db 'compile_err'
					Jobs.statuses\for_db 'error'
				}
			)[1].count
		},
		{ "is_active", fetch: =>
			(db.select "count(problems.id) from problems
			inner join competition_problems on competition_problems.problem_id = problems.id
			inner join competitions on competitions.id = competition_problems.competition_id
			where competitions.active=TRUE and problem_id=?", @id)[1].count > 0
		}
	}

	@get_codegolf_leaders: (problem_id, competition_id) =>
		db.select "user_id, problem_id, competition_id, status, time_initiated, char_length(code) as bytes
			from jobs
			where problem_id=? and competition_id=?
			order by status asc, bytes asc, time_initiated asc", problem_id, competition_id

	@clear_codegolf_scores: (problem_id, competition_id) =>
		db.query "update leaderboard_problems
			set points=0, status=1
			from leaderboard_placements
			where problem_id=? and leaderboard_placements.competition_id=?", problem_id, competition_id
