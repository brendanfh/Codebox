import respond_to from require "lapis.application"
bind = require 'utils.binding'

{
	make_controller: (routes) ->
		respond_to {
			before: =>
				if routes.inject
					for inj, dep in pairs routes.inject
						@[inj] = bind\make dep

				return if not routes.middleware

				for middleware in *routes.middleware
					require("#{@app.middleware_prefix}.#{middleware}") @

			GET: => routes.get(@)
			POST: => routes.post(@)
		}
}
