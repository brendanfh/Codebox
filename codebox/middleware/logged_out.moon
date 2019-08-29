import Users from require 'models'

=>
	if @session.user_id
		@user = Users\find(@session.user_id)
		@write redirect_to: @url_for 'index' if @user
