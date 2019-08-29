import Model from require "lapis.db.model"

class Jobs extends Model
	@relations: {
		{ 'user', belongs_to: 'Users' }
		{ 'problem', belongs_to: 'Problems' }
	}
