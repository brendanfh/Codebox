import make_controller from require "controllers.controller"

make_controller
	inject:
		scoring: 'scoring'

	get: =>
		res = @scoring\rescore_everything!
		return json: 'Rescored everything'
