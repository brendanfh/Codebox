import Model from require 'lapis.db.model'
db = require 'lapis.db'

class Competitions extends Model
	@relations: {
		{ "problems", fetch: =>
			db.select "problems.name, problems.short_name, problems.kind, problems.time_limit, competition_problems.letter
			from problems
			inner join competition_problems on problems.id = competition_problems.problem_id
			inner join competitions on competition_problems.competition_id = competitions.id
			where competitions.id=? orber by competition_problems.letter asc", @id
		}
	}
