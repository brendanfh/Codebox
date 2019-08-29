import create_table, types from require "lapis.db.schema"

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
			{ "user_id", types.foreign_key },
			{ "problem_id", types.foreign_key },
			{ "status", types.text null: true },
			{ "lang", types.varchar },
			{ "code", types.text null: true },
			{ "time_initiated", types.time },

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
}
