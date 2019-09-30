import Model from require 'lapis.db.model'

class CompetitionUsers extends Model
	@relations: {
		{ "competition", belongs_to: 'Competitions' }
		{ "user", belongs_to: 'Users' }
	}
