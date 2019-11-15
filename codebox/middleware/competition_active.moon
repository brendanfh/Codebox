
=>
	unless @competition
		@write json: 'Competition not loaded'

	unless @competition.active
		@write redirect_to: (@url_for 'index')
