lapis = require "lapis"
console = require "lapis.console"

import Users, Competitions from require "models"
bind = require "utils.binding"

bind\bind_static 'executer', require 'facades.executer'
bind\bind_static 'crypto', -> require 'services.crypto'

bind\bind_static 'uuidv4', ->
	math.randomseed os.time!
	return ->
		template ='xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
		return string.gsub template, '[xy]', (c) ->
			v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
			string.format '%x', v

-- Helper function that sppeds up requests by
-- delaying the requiring of the controllers
controller = (cont) ->
	return =>
		return (require ("controllers.#{cont}")) @

class extends lapis.Application
	layout: require "views.partials.layout"

	views_prefix: 'views'
	flows_prefix: 'flows'
	middleware_prefix: 'middleware'

	@before_filter =>
		@navbar = {}
		@navbar.selected = -1

		@scripts = {}

	['index':    		 "/"]: 		   controller "index"

	['account.login':    "/login"]:    controller "account.login"
	['account.logout':   "/logout"]:   controller "account.logout"
	['account.register': "/register"]: controller "account.register"

	['executer.status_update': "/executer/status_update"]: controller "executer.status_update"
	['executer.request': '/executer/request']: controller "executer.request"

	['admin': "/admin"]: => redirect_to: @url_for "admin.user"

	['admin.user': "/admin/user"]: controller "admin.user"
	['admin.user.reset_password': "/admin/user/reset_password"]: controller "admin.user.reset_password"
	['admin.user.delete': "/admin/user/delete"]: controller "admin.user.delete"

	['admin.problem': "/admin/problem"]: controller "admin.problem"
	['admin.problem.new': "/admin/problem/new"]: controller "admin.problem.new"
	['admin.problem.edit': "/admin/problem/edit/:problem_name"]: controller "admin.problem.edit"
	['admin.problem.delete': "/admin/problem/delete"]: controller "admin.problem.delete"

	['admin.testcase.new':    "/admin/testcase/new"]:    controller "admin.testcase.new"
	['admin.testcase.edit':   "/admin/testcase/edit"]:   controller "admin.testcase.edit"
	['admin.testcase.delete': "/admin/testcase/delete"]: controller "admin.testcase.delete"

	['admin.submission': "/admin/submission"]: controller "admin.submission"
	['admin.submission.edit': "/admin/submission/edit"]: controller "admin.submission.edit"
	['admin.submission.delete': "/admin/submission/delete"]: controller "admin.submission.delete"

	['admin.competition': "/admin/competition"]: controller "admin.competition"
	['admin.competition.new': "/admin/competition/new"]: controller "admin.competition.new"
	['admin.competition.edit': "/admin/competition/edit/:competition_id"]: controller "admin.competition.edit"
	['admin.competition.delete': "/admin/competition/delete/:competition_id"]: controller "admin.competition.delete"

	[test: '/test']: =>
		user = Users\find 5
		jobs = user\get_current_jobs!

		json: jobs

	"/console": console.make!
