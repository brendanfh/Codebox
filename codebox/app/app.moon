lapis = require "lapis"
console = require "lapis.console"

bind = require "utils.binding"
bind\bind_static 'executer', require 'facades.executer'
bind\bind_static 'updater', require 'facades.updater'
bind\bind_static 'crypto', require 'services.crypto'
bind\bind_static 'uuidv4', require 'services.uuid'
bind\bind_static 'queries', require 'services.queries'
bind\bind_static 'scoring', require 'services.scoring'
bind\bind_static 'time', require 'utils.time'

-- Helper function that speeds up requests by
-- delaying the requiring of the controllers
controller = (cont) ->
	return =>
		return (require ("controllers.#{cont}")) @

class extends lapis.Application
	layout: require "views.partials.layout"

	views_prefix: 'views'
	flows_prefix: 'flows'
	middleware_prefix: 'middleware'

	bind: bind

	@before_filter =>
		@navbar = {}
		@navbar.selected = -1

		@scripts = {}
		@raw_scripts = {}

	['index':    		 "/"]: => redirect_to: @url_for 'problem'

	['account.login':    "/login"]:    controller "account.login"
	['account.logout':   "/logout"]:   controller "account.logout"
	['account.register': "/register"]: controller "account.register"
	['account.account':  "/account"]:  controller "account.account"

    ['leaderboard': '/leaderboard']: controller "leaderboard.view"
    ['leaderboard.update': '/leaderboard/update']: controller "leaderboard.update"

	['problem': '/problems']: controller "problem.problem"
	['problem.description': '/problems/:problem_name']: controller "problem.problem"
	['problem.submit': '/problems/:problem_name/submit']: controller "problem.submit"

	['submission.list': '/submissions']: controller "submission.list"
	['submission.view': '/submissions/view']: controller "submission.view"
	['submission.status': '/submissions/status']: controller "submission.status"

	['executer.status_update': "/executer/status_update"]: controller "executer.status_update"
	['executer.request': '/executer/request']: controller "executer.request"

	['admin': "/admin"]: => redirect_to: @url_for "admin.user"

	['admin.user': "/admin/users"]: controller "admin.user"
	['admin.user.reset_password': "/admin/users/reset_password"]: controller "admin.user.reset_password"
	['admin.user.delete': "/admin/users/delete"]: controller "admin.user.delete"

	['admin.problem': "/admin/problems"]: controller "admin.problem"
	['admin.problem.new': "/admin/problems/new"]: controller "admin.problem.new"
	['admin.problem.edit': "/admin/problems/edit/:problem_name"]: controller "admin.problem.edit"
	['admin.problem.delete': "/admin/problems/delete"]: controller "admin.problem.delete"

	['admin.testcase.new':    "/admin/testcases/new"]:    controller "admin.testcase.new"
	['admin.testcase.edit':   "/admin/testcases/edit"]:   controller "admin.testcase.edit"
	['admin.testcase.delete': "/admin/testcases/delete"]: controller "admin.testcase.delete"

	['admin.submission': "/admin/submissions"]: controller "admin.submission"
	['admin.submission.edit': "/admin/submissions/edit"]: controller "admin.submission.edit"
	['admin.submission.delete': "/admin/submissions/delete"]: controller "admin.submission.delete"

	['admin.competition': "/admin/competitions"]: controller "admin.competition"
	['admin.competition.new': "/admin/competitions/new"]: controller "admin.competition.new"
	['admin.competition.edit': "/admin/competitions/edit/:competition_id"]: controller "admin.competition.edit"
	['admin.competition.delete': "/admin/competitions/delete/:competition_id"]: controller "admin.competition.delete"
	['admin.competition.add_problem': "/admin/competitions/add_problem"]: controller "admin.competition.add_problem"
	['admin.competition.delete_problem': "/admin/competitions/delete_problem"]: controller "admin.competition.delete_problem"
	['admin.competition.activate': "/admin/competitions/activate/:competition_id"]: controller "admin.competition.activate"

    ['admin.utils.score': "/admin/score"]: controller "admin.utils.score"

	"/console": console.make!
