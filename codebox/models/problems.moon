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
			(db.query "select count(job_id) from jobs where problem_id=? and status=4", @id)[1].count
		}
		{ "wrong_answer_jobs", fetch: =>
			(db.query "select count(job_id) from jobs where problem_id=? and status=5", @id)[1].count
		}
		{ "timed_out_jobs", fetch: =>
			(db.query "select count(job_id) from jobs where problem_id=? and status=6", @id)[1].count
		}
		{ "error_jobs", fetch: =>
			(db.query "select count(job_id) from jobs where problem_id=? and status in ?", @id,
				db.list {
					Jobs.statuses\for_db 'compile_err'
					Jobs.statuses\for_db 'error'
				}
			)[1].count
		}
	}
