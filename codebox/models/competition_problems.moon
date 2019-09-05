import Model from require 'lapis.db.model'

class CompetitionProblems extends Model
	@relations: {
		{ "problem", belongs_to: 'Problems' }
		{ "competition", belongs_to: 'Competitions' }
	}
