class Binding
	new: =>
		@bindings = {}
		@static_bindings = {}
		@statics = {}

	bind: (name, service) =>
		@bindings[name] = service

	bind_static: (name, service) =>
		@static_bindings[name] = service

	make: (name, ...) =>
		if @bindings[name]
			return @bindings[name](...)
		elseif @statics[name]
			return @statics[name]
		elseif @static_bindings[name]
			stat = @static_bindings[name](...)
			@statics[name] = stat
			return stat

return Binding()
