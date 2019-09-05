import Model, enum from require "lapis.db.model"
db = require 'lapis.db'

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
		{ "correct_jobs", fetch: =>
			db.query "select count(job_id) from jobs where problem_id=? and status=4", @id
		}
		{ "wrong_answer_jobs", fetch: =>
			db.query "select count(job_id) from jobs where problem_id=? and status=5", @id
		}
		{ "timed_out_jobs", fetch: =>
			db.query "select count(job_id) from jobs where problem_id=? and status=6", @id
		}
	}
