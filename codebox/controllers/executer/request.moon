import make_controller from require "controllers.controller"
import assert_valid from require "lapis.validate"
import capture_errors from require 'lapis.application'

make_controller
	inject:
		executer: 'executer'

	middleware: { 'internal_request' }

	post: capture_errors (=>
		assert_valid @params, {
			{ 'lang', exists: true }
			{ 'code', exists: true }
			{ 'problem_id', exists: true, is_integer: true }
		}

		id = @executer\request @params.lang, @params.code

		json: id
	), =>
		json: { status: 'error occured', errors: @errors }



