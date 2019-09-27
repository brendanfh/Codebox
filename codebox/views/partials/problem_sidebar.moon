html = require 'lapis.html'
import Competitions, Users from require 'models'

class ProblemSidebar extends html.Widget
    load_problems: =>
        @current_comp = Competitions\find active: true
    	@problems = @current_comp\get_problems!

		for prob in *@problems
			if Users\has_correct_submission @user.id, prob.short_name
				prob.tag = "correct"
			elseif Users\has_incorrect_submission @user.id, prob.short_name
				prob.tag = "incorrect"

    content: =>
        @load_problems!

        for prob in *@problems
            a href: (@url_for 'problem.description', problem_name: prob.short_name), ->
                div {
                    selected: prob.short_name == @params.problem_name
                    correct: prob.tag == "correct"
                    wrong: prob.tag == "incorrect"
                    class: 'sidebar-problem'
                }, ->
                    div class: 'sidebar-problem-letter', -> text prob.letter
                    div class: 'sidebar-problem-name', -> text prob.name
