import Model from require "lapis.db.model"

class Users extends Model
	@relations: {
		{ 'jobs', has_many: 'Jobs' }
		{ 'c_jobs'
			has_many: 'Jobs'
			where: { lang: 'C' }
		}
	}
