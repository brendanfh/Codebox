import Injectable from require 'utils.inject'
import Users, Problems, Competitions, LeaderboardProblems, LeaderboardPlacements from require 'models'

class Scoring extends Injectable
	new: =>
		@queries = @make 'queries'
        @time = @make 'time'
        @competition = Competitions\find active: true

        @competition_start = @time.time_to_number @competition.start
        @competition_end = @time.time_to_number @competition.end

    setup_scoring_tables: =>
        @queries.delete_leaderboard_for_competition @competition.id

        users = Users\select!
        problems = @competition\get_competition_problems!

        for user in *users
            placement = LeaderboardPlacements\create
                competition_id: @competition.id
                user_id: user.id

            for problem in *problems
                LeaderboardProblems\create
                    leaderboard_placement_id: placement.id
                    user_id: user.id
                    problem_id: problem.problem_id

    get_problem_worth: (time_submitted) =>
        start = @competition_start + 30 * 60
        return 1 if time_submitted < start
        duration = @competition_end - start
        percent = (time_submitted - start) / duration
        1 - 0.5 * percent

    score_problem_for_user: (user_id, problem_shortname) =>
        placement = LeaderboardPlacements\find user_id: user_id, competition_id: @competition.id
        status = LeaderboardProblems.statuses.not_attempted
        points = 0
        attempts = 0

        problem = Problems\find short_name: problem_shortname

        -- THIS SHOULD SWITCH ON PROBLEM KIND

        attempts += @queries.count_incorrect_submission user_id, problem_shortname
        if attempts > 0
            status = LeaderboardProblems.statuses.wrong

        if @queries.has_correct_submission user_id, problem_shortname
            job = @queries.get_first_correct_submission user_id, problem.id, @competition.id

            points += math.ceil (1000 * @get_problem_worth job.time_initiated)
            points -= 50 * attempts
            status = LeaderboardProblems.statuses.correct
            attempts += 1

        lp = LeaderboardProblems\find problem_id: problem.id, leaderboard_placement_id: placement.id
        lp\update
            status: status
            points: points
            attempts: attempts

	score_user: (user_id) =>
        problems = @competition\get_competition_problems!
        for p in *problems
            problem = p\get_problem!
            @score_problem_for_user user_id, problem.short_name

    score_problem: (problem_name) =>
        users = Users\select!
        for u in *users
            @score_problem_for_user u.id, problem_name

    score_all: =>
        problems = @competition\get_competition_problems!
        for p in *problems
            problem = p\get_problem!
            @score_problem problem.short_name

    place: =>
        users = Users\select!

        for u in *users
            u.score = @queries.get_user_score u.id, @competition.id

        table.sort users, (a, b) ->
            a.score - b.score

        last_score = 1e308
        num, act_num = 0, 0
        for u in *users
            act_num += 1
            if last_score > u.score
                num = act_num
                last_score = u.score
            lp = LeaderboardPlacements\find user_id: u.id, competition_id: @competition.id
            lp\update
                place: num
                score: u.score
