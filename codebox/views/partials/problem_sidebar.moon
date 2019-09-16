html = require 'lapis.html'
import Competitions from require 'models'

class ProblemSidebar extends html.Widget
    load_problems: =>
        @current_comp = Competitions\find active: true
    	@problems = @current_comp\get_problems!

		for prob in *@problems
			if @queries.has_correct_submission @user.id, prob.short_name
				prob.tag = "correct"
			elseif @queries.has_incorrect_submission @user.id, prob.short_name
				prob.tab = "incorrect"

    content: =>
        @load_problems!

        for prob in *@problems
            a href: (@url_for 'problem.description', problem_name: prob.short_name), ->
                div {
                    selected: prob.short_name == @params.problem_name
                    correct: prob.tag == "correct"
                    wrong: prob.tab == "incorrect"
                    class: 'sidebar-problem'
                }, ->
                    div class: 'sidebar-problem-letter', -> text prob.letter
                    div class: 'sidebar-problem-name', -> text prob.name