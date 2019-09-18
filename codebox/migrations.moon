import create_table, add_column, types from require "lapis.db.schema"
import insert from require "lapis.db"

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
			{ "competition_id", types.foreign_key },
			{ "status", types.enum },
			{ "lang", types.varchar },
			{ "code", types.text null: true },
			{ "time_initiated", types.integer },
			{ "data", types.text null: true },

			"PRIMARY KEY (id)"
		}

	[3]: =>
		create_table "problems", {
			{ "id", types.serial },
			{ "short_name", types.varchar unique: true },
			{ "name", types.varchar },
			{ "kind", types.enum },
			{ "description", types.text null: true },
			{ "time_limit", types.integer },

			"PRIMARY KEY (id)"
		}

	[4]: =>
		create_table "test_cases", {
			{ "id", types.serial },
			{ "uuid", types.varchar unique: true },
			{ "problem_id", types.foreign_key },
			{ "testcase_order", types.integer, default: 1 }
			{ "input", types.text },
			{ "output", types.text },

			"PRIMARY KEY (id)"
		}

	[5]: =>
		insert "users", {
			username: "admin"
			password_hash: "$2b$10$uZasTmdngnbGO4ogkvY9b.S7bn.YxLJseCc3MufyX7S0wr5UpgNxy"
			nickname: "admin"
			email: "admin@admin.org"
		}

	[6]: =>
		create_table "competitions", {
			{ "id", types.serial }
			{ "start", types.time null: true }
			{ "end", types.time null: true }
			{ "name", types.varchar }
			{ "active", types.boolean }
		}

	[7]: =>
		create_table "competition_problems", {
			{ "id", types.serial }
			{ "competition_id", types.foreign_key }
			{ "problem_id", types.foreign_key }
			{ "letter", types.varchar }
		}
}
