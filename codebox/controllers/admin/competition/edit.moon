import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors, capture_errors_json, yield_error from require 'lapis.application'
import Competitions, Problems, Users from require 'models'

make_controller
	layout: require 'views.partials.admin_layout'

	middleware: { 'logged_in', 'admin_required' }

	get: capture_errors_json =>
		assert_valid @params, {
			{ "competition_id", exists: true, is_integer: true }
		}

		@navbar.selected = 3

		@comp = Competitions\find @params.competition_id
		unless @comp
			yield_error "Competition not found"
			return

		@comp_problems = @comp\get_problems!
		@comp_users = @comp\get_competition_users!
		Users\include_in @comp_users, 'id',
			flip: true
			as: 'u'
			local_key: 'user_id'
		@all_problems = Problems\select!

		-- Postgres puts a space between the date and time, need a T
		if @comp.start
			@comp.start = @comp.start\gsub " ", "T"
		if @comp.end
			@comp.end = @comp.end\gsub " ", "T"

		render: true

	post: capture_errors =>
		@navbar.selected = 3

		assert_valid @params, {
			{ "id", exists: true, is_integer: true }
			{ "name", exists: true }
			{ "start_time", exists: true }
			{ "end_time", exists: true }
            { "time_offset", exists: true }
            { "programming_points", exists: true }
            { "codegolf_points", exists: true }
            { "word_points", exists: true }
			{ "short_name", exists: true }
		}

		@comp = Competitions\find @params.id
		unless @comp
			yield_error "Competition not found"

		@comp\update {
			name: @params.name
			start: @params.start_time
			end: @params.end_time
            time_offset: @params.time_offset
            programming_points: @params.programming_points
            codegolf_points: @params.codegolf_points
            word_points: @params.word_points
			short_name: @params.short_name
		}
		@comp\refresh!

		redirect_to: @url_for "admin.competition.edit", { competition_id: @params.id }
