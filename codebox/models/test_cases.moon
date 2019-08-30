import Model from require 'lapis.db.model'

class TestCases extends Model
	@relations: {
		{ "problem", belongs_to: 'Problems' }
	}
