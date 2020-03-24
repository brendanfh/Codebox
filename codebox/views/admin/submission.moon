html = require "lapis.html"
import Jobs, Users, Problems from require "models"

class AdminSubmission extends html.Widget
	content: =>
		h1 'Submissions'

		div class: 'content', ->
			div class: 'bcolor-pd pad-12 pad-l-44 split-6', ->
				span "Username"
				span "Problem"
				span "Competition ID"
				span "Status"
				span "Language"
				span "Bytes"

			div class: 'box', ->
				Users\include_in @jobs, 'id',
					flip: true
					as: 'user'
					local_key: 'user_id'
				Problems\include_in @jobs, 'id',
					flip: true
					as: 'problem'
					local_key: 'problem_id'

				for job in *@jobs
					color = "primary-dark"
					switch job.status
						when Jobs.statuses.correct then color = "success"
						when Jobs.statuses.wrong_answer then color = "error"
						when Jobs.statuses.timed_out then color = "error"
						when Jobs.statuses.compile_err then color = "error"

					div class: "tabbed-split tab-32 #{color}", ->
						span ""
						a href: (@url_for 'admin.submission.edit', {}, { submission_id: job.job_id }), ->
							div class: 'highlight pad-12 split-6', ->
								unless job.user
									span "#{job.user.username}"
								else
									span "UNKNOWN: #{job.user_id}"
								span "#{job.problem.short_name}"
								span "#{job.competition_id}"
								span "#{Jobs.statuses\to_name job.status}"
								span "#{job.lang}"
								span "#{job.bytes}"

