import Model, enum from require "lapis.db.model"

class LeaderboardProblems extends Model
    @statuses: enum {
        not_attempted: 1
        attempted: 2
        correct: 3
        wrong: 4
		hidden: 5
    }

    @relations: {
        { "leaderboard_placement", belongs_to: 'LeaderboardPlacements' }
        { "user", belongs_to: 'Users' }
        { "problem", belongs_to: 'Problems' }
    }
