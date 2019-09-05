import Model from require "lapis.db.model"
db = require 'lapis.db'

class Users extends Model
	@relations: {
		{ 'jobs', has_many: 'Jobs' }
		{ 'current_jobs', fetch: =>
			db.select "jobs.job_id, jobs.problem_id, jobs.lang, jobs.code, jobs.status, jobs.data, jobs.time_initiated from jobs
			inner join competition_problems on competition_problems.problem_id = jobs.problem_id
			inner join competitions on competitions.id = competition_problems.competition_id
			where competitions.active=? and jobs.user_id=?", db.TRUE, @id
		}
	}
