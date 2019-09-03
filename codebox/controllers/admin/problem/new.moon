import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Problems from require 'models'

make_controller
	layout: require 'views.partials.admin_layout'

	middleware: { 'logged_in', 'admin_required' }

	get: =>
		@flow 'csrf_setup'

		@navbar.selected = 1

		@problems = Problems\select!

		return {
			layout: require 'views.partials.admin_layout'
			render: 'admin.problem.new'
		}

	post: capture_errors =>
		@flow 'csrf_validate'

		assert_valid @params, {
			{ 'short_name', exists: true }
			{ 'name', exists: true }
			{ 'description', exists: true }
			{ 'time_limit', exists: true, is_integer: true }
		}

		if Problems\find short_name: @params.short_name
			yield_error "Problem with short name, #{@params.short_name}, already exists"
			return

		problem = Problems\create {
			short_name: @params.short_name
			name: @params.name
			kind: Problems.kinds\for_db 'code'
			description: @params.description
			time_limit: @params.time_limit
		}

		if problem then
			return redirect_to: (@url_for 'admin.problem.edit', problem_name: @params.short_name)
		else
			yield_error "There was an error creating the problem"
