import respond_to from require "lapis.application"

{
	make_controller: (routes) ->
		respond_to {
			before: =>
				if routes.inject
					for inj, dep in pairs routes.inject
						@[inj] = @app.bind\make dep, @

				if routes.scripts
					for s in *routes.scripts
						table.insert @scripts, s

				if routes.raw_scripts
					for s in *routes.raw_scripts
						table.insert @raw_scripts, s

				return if not routes.middleware

				for middleware in *routes.middleware
					pcall(require("#{@app.middleware_prefix}.#{middleware}"), @)

			GET: =>
				r = routes.get(@)
				if type(r) == "table"
					r.layout or= routes.layout
				return r
			POST: =>
				r = routes.post(@)
				if type(r) == "table"
					r.layout or= routes.layout
				return r
			DELETE: =>
				r = routes.delete(@)
				if type(r) == "table"
					r.layout or= routes.layout
				return r
		}
}
