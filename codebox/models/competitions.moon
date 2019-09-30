import Model from require 'lapis.db.model'
db = require 'lapis.db'
time = (require 'utils.time')!

class Competitions extends Model
	@relations: {
		{ "problems", fetch: =>
			db.select "problems.id AS problem_id, problems.name, problems.short_name, problems.kind, problems.time_limit, competition_problems.letter
			from problems
			inner join competition_problems on problems.id = competition_problems.problem_id
			inner join competitions on competition_problems.competition_id = competitions.id
			where competitions.id=? order by competition_problems.letter asc", @id
		}
		{ "problem_ids", fetch: =>
			db.select "problems.id AS id
			from problems
			inner join competition_problems on problems.id = competition_problems.problem_id
			inner join competitions on competition_problems.competition_id = competitions.id
			where competitions.id=? order by competition_problems.letter asc", @id
		}
		{ "competition_users", has_many: "CompetitionUsers" }
		{ "competition_problems", has_many: "CompetitionProblems" }
		{ "jobs", has_many: "Jobs" }
		{ "leaderboard", has_many: "LeaderboardPlacements", order: "place asc" }
        { "start_time_num", fetch: =>
            (time.time_to_number @start) + @time_offset * 60
        }
	    { "end_time_num", fetch: =>
            (time.time_to_number @['end']) + @time_offset * 60
        }
    }

	@delete_leaderboard: (competition_id) =>
		db.query "delete from leaderboard_problems
			where leaderboard_placement_id in
				(select id from leaderboard_placements where competition_id=?)", competition_id

		db.delete "leaderboard_placements", competition_id: competition_id
