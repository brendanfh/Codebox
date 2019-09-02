=>
	unless @user.username == "admin"
		@write redirect_to: @url_for 'index'

