html = require "lapis.html"
import Jobs from require "models"

class AdminSubmission extends html.Widget
	content: =>
		h1 'Submissions'

		div class: 'content', ->
			for job in *@jobs
				div class: 'w50 left pad-12', ->
					div class: 'option-line', ->
						span "#{job.job_id}"
						div class: 'button-list', ->
							a href: (@url_for 'admin.submission.edit', {}, { submission_id: job.job_id }), 'View'

					div class: 'box', ->
						div class: 'highlight pad-12 split-lr', ->
							span 'Status:'
							span Jobs.statuses\to_name job.status
						div class: 'highlight pad-12 split-lr', ->
							span 'User id:'
							span job.user_id
						div class: 'highlight pad-12 split-lr', ->
							span 'Problem id:'
							span job.problem_id
						div class: 'highlight pad-12 split-lr', ->
							span 'Language:'
							span job.lang

