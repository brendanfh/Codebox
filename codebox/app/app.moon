lapis = require "lapis"
console = require "lapis.console"

import Users from require "models"
bind = require "utils.binding"

bind\bind_static 'executer', require 'facades.executer'
bind\bind_static 'crypto', -> require 'services.crypto'

class extends lapis.Application
	layout: require "views.partials.layout"

	views_prefix: 'views'
	flows_prefix: 'flows'
	middleware_prefix: 'middleware'

	@before_filter =>
		@navbar = {}
		@navbar.selected = -1

	['index':    		 "/"]: 		   require "controllers.index"

	['account.login':    "/login"]:    require "controllers.account.login"
	['account.logout':   "/logout"]:   require "controllers.account.logout"
	['account.register': "/register"]: require "controllers.account.register"

	['executer.status_update': "/executer/status_update"]: require "controllers.executer.status_update"
	['executer.request': '/executer/request']: require "controllers.executer.request"

	['admin.user': "/admin/user"]: => "NOT IMPLEMENTED"

	['admin.problem': "/admin/problem"]: require "controllers.admin.problem"
	['admin.problem.new': "/admin/problem/new"]: require "controllers.admin.problem.new"
	['admin.problem.edit': "/admin/problem/edit/:problem_name"]: require "controllers.admin.problem.edit"

	['admin.submission': "/admin/submission"]: => "NOT IMPLEMENTED"
	['admin.competition': "/admin/competition"]: => "NOT IMPLEMENTED"

	"/console": console.make!
