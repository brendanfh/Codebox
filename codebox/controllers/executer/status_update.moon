import make_controller from require "controllers.controller"

make_controller
	middleware: { 'internal_request' }

	post: =>
		print 'Hit status'
		json: { status: 'success' }
