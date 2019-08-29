csrf = require "lapis.csrf"

=>
	@csrf_token = csrf.generate_token @
	return
