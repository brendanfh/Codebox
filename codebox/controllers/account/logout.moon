import make_controller from require "controllers.controller"

make_controller {
	get: =>
		@session.user_id = nil
		return redirect_to: @url_for 'index'
}
