import Injectable from require 'utils.inject'
import Users, Jobs, Problems, Competitions, LeaderboardProblems, LeaderboardPlacements from require 'models'
require 'utils.table'

class Scoring extends Injectable
	new: =>
		@queries = @make 'queries'
        @time = @make 'time'

        -- Get the currently active competition
        @competition = Competitions\find active: true

        -- Load the problems and users that are going to be scored
        @comp_problems = @competition\get_competition_problems!
        @users = Users\select!

        -- Get the start and end time in a UTC time number
        @competition_start = @competition\get_start_time_num!
        @competition_end = @competition\get_end_time_num!

    setup_scoring_tables: =>
        -- Delete all old leaderboard entries for this competition
        @queries.delete_leaderboard_for_competition @competition.id

        -- Refetch the problems and users in case they have changed
        @comp_problems = @competition\get_competition_problems!
        @users = Users\select!

        for user in *@users
            -- Create a placement on the leaderboard for each user
            placement = LeaderboardPlacements\create
                competition_id: @competition.id
                user_id: user.id

            for problem in *@comp_problems
                -- Create a problem on the placement for each problem
                LeaderboardProblems\create
                    leaderboard_placement_id: placement.id
                    user_id: user.id
                    problem_id: problem.problem_id

    get_problem_worth: (time_submitted) =>
        -- Start the linear decent of the problem worth
        -- 30 minutes after the competition starts so
        -- they have a chance to submit a problem
        -- or two before they lose points

        start = @competition_start + 30 * 60
        return 1 if time_submitted < start

        duration = @competition_end - start
        percent = (time_submitted - start) / duration
        1 - 0.5 * percent

    score_problem_for_user: (user_id, problem) =>
        -- Get the placement for the user during this competition
        placement = LeaderboardPlacements\find user_id: user_id, competition_id: @competition.id

        status = LeaderboardProblems.statuses.not_attempted
        points = 0
        attempts = 0

        -- Count the incorrect submissions, and if there are
        -- any, set the status of the problem to be wrong
        attempts += @queries.count_incorrect_submission user_id, problem.short_name
        if attempts > 0
            status = LeaderboardProblems.statuses.wrong

        -- If there is a correct submission, get the first one
        -- (best for problem worth) and compute the points
        -- for this problem:
        --     points = programming_points * worth - 50 * wrong_attempts
        if @queries.has_correct_submission user_id, problem.short_name
            job = @queries.get_first_correct_submission user_id, problem.id, @competition.id

            points += math.ceil (@competition.programming_points * @get_problem_worth job.time_initiated)
            points -= 50 * attempts
            status = LeaderboardProblems.statuses.correct
            attempts += 1

        -- Update the problem in the database
        lp = LeaderboardProblems\find problem_id: problem.id, leaderboard_placement_id: placement.id
        lp\update
            status: status
            points: points
            attempts: attempts

    score_codegolf: (problem) =>
        -- Clear the codegolf scores for this problem in this competition
        @queries.clear_codegolf_scores problem.id, @competition.id

        -- Get the best code golf submisssions
        leaders = @queries.get_codegolf_leaders problem.id, @competition.id

        points = @competition.codegolf_points
        third_points = points / 3
        placed_leaders = {}

        -- For each submission, if the user has already attained
        -- points, skip that submission
        for leader in *leaders
            continue if table.contains placed_leaders, leader.user_id
            table.insert placed_leaders, leader.user_id

            placement = LeaderboardPlacements\find user_id: leader.user_id, competition_id: @competition.id
            lp = LeaderboardProblems\find problem_id: problem.id, leaderboard_placement_id: placement.id
            if leader.status == Jobs.statuses.correct
                lp\update
                    status: LeaderboardProblems.statuses.correct
                    points: points
                    attempts: leader.bytes
                points -= third_points if points > 0
            else
                lp\update
                    status: LeaderboardProblems.statuses.wrong
                    points: 0
                    attempts: 0

	score_user: (user_id) =>
        for p in *@comp_problems
            problem = p\get_problem!
            @score_problem_for_user user_id, problem

    score_problem: (problem_name) =>
        problem = Problems\find short_name: problem_name
        for u in *@users
            @score_problem_for_user u.id, problem

    score_all: =>
        for p in *@comp_problems
            for u in *@users
                @score u.id, p.problem_id

    score: (user_id, problem_id) =>
        problem = Problems\find problem_id
        switch problem.kind
            when Problems.kinds.code then @score_problem_for_user user_id, problem
            when Problems.kinds.golf then @score_codegolf problem
            when Problems.kinds.word then @score_word_for_user user_id, problem

    place: =>
        for u in *@users
            u.score = @queries.get_user_score u.id, @competition.id

        table.sort @users, (a, b) ->
            a.score > b.score

        -- If n users have the same score, they are both place x, and
        -- the next person is place x + n.
        last_score = 1e308
        num, act_num = 0, 0
        for u in *@users
            act_num += 1
            if last_score > u.score
                num = act_num
                last_score = u.score

            lp = LeaderboardPlacements\find user_id: u.id, competition_id: @competition.id
            lp\update
                place: num
                score: u.score

    rescore_everything: =>
        -- Completely resets everything if a problem is
        -- added or removed or if a user registers
        @setup_scoring_tables!
        @score_all!
        @place!
