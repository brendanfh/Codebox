csrf = require "lapis.csrf"

=>
	csrf.assert_token @
	@csrf_token = csrf.generate_token @
