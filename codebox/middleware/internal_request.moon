config = (require 'lapis.config').get!

=>
	if @params.request_token != config.req_secret
		@write {
			status: 401
			json: { status: 'Unauthorized' }
		}
