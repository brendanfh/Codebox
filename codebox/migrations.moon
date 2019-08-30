import create_table, add_column, types from require "lapis.db.schema"

{
	[1]: =>
		create_table "users", {
			{ "id", types.serial },
			{ "username", types.varchar },
			{ "password_hash", types.varchar },
			{ "nickname", types.varchar },
			{ "email", types.varchar },

			"PRIMARY KEY (id)"
		}

	[2]: =>
		create_table "jobs", {
			{ "id", types.serial },
			{ "job_id", types.varchar unique: true },
			{ "user_id", types.foreign_key },
			{ "problem_id", types.foreign_key },
			{ "status", types.enum },
			{ "lang", types.varchar },
			{ "code", types.text null: true },
			{ "time_initiated", types.time },
			{ "data", types.text null: true },

			"PRIMARY KEY (id)"
		}

	[3]: =>
		create_table "problems", {
			{ "id", types.serial },
			{ "name", types.varchar },
			{ "kind", types.enum },
			{ "description", types.text null: true },
			{ "time_limit", types.integer },

			"PRIMARY KEY (id)"
		}

	[4]: =>
		create_table "test_cases", {
			{ "id", types.serial },
			{ "problem_id", types.foreign_key },
			{ "input", types.varchar },
			{ "output", types.varchar },

			"PRIMARY KEY (id)"
		}
}
