import Model, enum from require "lapis.db.model"

class LeaderboardPlacements extends Model
    @relations: {
        { 'competition', belongs_to: 'Competitions' }
        { 'user', belongs_to: 'Users' }
    }