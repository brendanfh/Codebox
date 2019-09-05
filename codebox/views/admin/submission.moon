html = require "lapis.html"
import Jobs from require "models"

class AdminSubmission extends html.Widget
	content: =>
		h1 'Submissions'

		div class: 'content', ->
			for job in *@jobs
				div class: 'option-line', ->
					span "#{job.job_id}"
					div class: 'button-list', ->
						a href: (@url_for 'admin.submission.edit', {}, { submission_id: job.job_id }), 'View'

				div class: 'box', ->
					div class: 'highlight pad-12 split-lr', ->
						span 'Status:'
						span Jobs.statuses\to_name job.status
					div class: 'highlight pad-12 split-lr', ->
						span 'Username:'
						span job\get_user!.username
					div class: 'highlight pad-12 split-lr', ->
						span 'Problem:'
						span job\get_problem!.short_name
					div class: 'highlight pad-12 split-lr', ->
						span 'Language:'
						span job.lang

