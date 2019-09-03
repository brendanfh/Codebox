import Model, enum from require "lapis.db.model"

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
	}
