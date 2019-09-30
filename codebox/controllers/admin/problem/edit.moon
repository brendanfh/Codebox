import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Problems from require 'models'

make_controller
	layout: require 'views.partials.admin_layout'

	middleware: { 'logged_in', 'admin_required' }

	scripts: { 'admin_problem', 'vendor/ace/ace' }

	get: capture_errors_json =>
		@flow 'csrf_setup'

		@navbar.selected = 1

		assert_valid @params, {
			{ "problem_name", exists: true }
		}

		@problem = Problems\find short_name: @params.problem_name
		unless @problem
			yield_error "Problem not found"

		@test_cases = @problem\get_test_cases!

		render: true

	post: capture_errors =>
		@flow 'csrf_validate'
		@navbar.selected = 1

		assert_valid @params, {
			{ "problem_name", exists: true }
			{ "problem_id", exists: true }
			{ "name", exists: true }
			{ "short_name", exists: true }
			{ "description", exists: true }
			{ "time_limit", exists: true, is_integer: true }
            { "kind", exists: true }
			{ "blacklisted_langs", exists: true }
		}

		@problem = Problems\find @params.problem_id
		unless @problem
			yield_error "Problem with id '#{@params.problem_id}' not found"
			return

		@problem\update {
			name: @params.name
			short_name: @params.short_name
			description: @params.description
			time_limit: @params.time_limit
            kind: Problems.kinds\for_db @params.kind
			blacklisted_langs: @params.blacklisted_langs
		}

		redirect_to: (@url_for "admin.problem.edit", problem_name: @params.short_name)
