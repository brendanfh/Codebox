import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions from require 'models'

make_controller
	layout: require 'views.partials.admin_layout'

	middleware: { 'logged_in', 'admin_required' }

	get: =>
		@flow 'csrf_setup'
		@navbar.selected = 3

		render: true

	post: capture_errors =>
		@flow 'csrf_validate'

		assert_valid @params, {
			{ "name", exists: true }
			{ "start_time", exists: true }
			{ "end_time", exists: true }
		}

		Competitions\create {
			name: @params.name
			start: @params.start_time
			end: @params.end_time
		}

		redirect_to: @url_for 'admin.competition'
