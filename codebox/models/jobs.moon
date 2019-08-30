import Model, enum from require "lapis.db.model"

class Jobs extends Model
	@statuses: enum {
		queued: 1
		compiling: 2
		running: 3
		completed: 4
		wrong_answer: 5
		timed_out: 6
		bad_language: 7
		bad_problem: 8
		compile_err: 9
		error: 10
	}

	@relations: {
		{ 'user', belongs_to: 'Users' }
		{ 'problem', belongs_to: 'Problems' }
	}
