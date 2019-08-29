import Users from require 'models'

=>
	if not @session.user_id
		@write redirect_to: @url_for 'account.login'
		return

	@user = Users\find(@session.user_id)
	if not @user
		@session.user_id = nil
		@write redirect_to: @url_for 'account.login'
		return
