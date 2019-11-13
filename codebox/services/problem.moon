bind = require 'utils.binding'
executer = bind\make 'executer'
import Problems from require 'models'

-> {
	submit: (problem_name, code, lang, user_id, comp_id) ->
        problem = Problems\find short_name: problem_name
        unless problem
            return json: { status: 'problem not found' }

        blacklisted = string.split problem.blacklisted_langs, ','
        if table.contains blacklisted, lang
            return json: { status: 'Language is blacklisted for this problem' }

        test_cases = problem\get_test_cases!

        id = executer\request lang, code, user_id, problem.id, comp_id, test_cases, problem.time_limit

        json: id
}
