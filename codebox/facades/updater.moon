config = (require 'lapis.config').get!
http = require 'lapis.nginx.http'

class UpdaterFacade
	push_submission_update: (job_id) =>
		http.simple "#{config.updater_addr}/submission_update?submission_id=#{job_id}"

	push_leaderboard_update: =>
		http.simple "#{config.updater_addr}/leaderboard_update"
