import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Problems from require 'models'

make_controller
	layout: require 'views.partials.admin_layout'

	middleware: { 'logged_in', 'admin_required' }

	scripts: { 'admin_problem', 'vendor/ace/ace' }
	raw_scripts: {
		"https://polyfill.io/v3/polyfill.min.js?features=es6"
		"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"
	}

	get: capture_errors_json =>
		@navbar.selected = 1

		assert_valid @params, {
			{ "problem_name", exists: true }
		}

		@problem = Problems\find short_name: @params.problem_name
		unless @problem
			yield_error "Problem not found"

		render: true
