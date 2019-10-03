html = require "lapis.html"
import Jobs, Users, Problems from require "models"

class AdminSubmission extends html.Widget
	content: =>
		h1 'Submissions'

		div class: 'content', ->
			div class: 'bcolor-pd pad-12 pad-l-44 split-6', ->
				span "User ID"
				span "Problem ID"
				span "Competition ID"
				span "Status"
				span "Language"
				span "Options"

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
						div class: 'highlight pad-12 split-6', ->
							span "#{job.user.username}"
							span "#{job.problem.short_name}"
							span "#{job.competition_id}"
							span "#{Jobs.statuses\to_name job.status}"
							span "#{job.lang}"
							div class: 'button-list', ->
								a href: (@url_for 'admin.submission.edit', {}, { submission_id: job.job_id }), 'View'

