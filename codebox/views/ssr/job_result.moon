html = require 'lapis.html'
import Jobs from require 'models'
import from_json from require 'lapis.util'

process_str = (str) ->
	str = str\gsub '\\/', '/'
	str\gsub '\\n', (string.char 10)

class JobResultView extends html.Widget
	new: (@job) =>
		@status_str = Jobs.statuses\to_name @job.status

		@username = @job\get_user!.username
		@problem = @job\get_problem!
        @bytes = @job.bytes
		@time_started = @job.time_initiated
		if @job.data
			@json_data = from_json @job.data
		else
			@json_data = nil

		@ring_color = ''
		switch @job.status
			when Jobs.statuses.correct then @ring_color = 'success'
			when Jobs.statuses.wrong_answer then @ring_color = 'error'
			when Jobs.statuses.timed_out then @ring_color = 'error'
			when Jobs.statuses.bad_language then @ring_color = 'error'
			when Jobs.statuses.bad_problem then @ring_color = 'error'
			when Jobs.statuses.compile_err then @ring_color = 'error'
			when Jobs.statuses.error then @ring_color = 'error'

		@show_slash = true
		switch @job.status
			when Jobs.statuses.compile_err then @show_slash = false
			when Jobs.statuses.queued then @show_slash = false
			when Jobs.statuses.bad_language then @show_slash = false
			when Jobs.statuses.bad_problem then @show_slash = false

		@message = 'Error'
		switch @job.status
			when Jobs.statuses.compiling then @message = 'Compiling'
			when Jobs.statuses.queued then @message = 'Queued'

		if @show_slash and type(@json_data) == "table"
			@completed_percentage = math.floor(100 * (@json_data.completed / @json_data.total))

	content: =>
		div class: 'fixed-half-split', ->
			div ->
				span class: "mar-t-12 mar-l-12 c100 p#{@completed_percentage} big dark #{@ring_color}", ->
					if @show_slash and type(@json_data) == "table"
						span -> text "#{@json_data.completed} / #{@json_data.total}"
					else
						span -> text @message

					div class: 'slice', ->
						div class: 'bar', ''
						div class: 'fill', ''

				div class: 'mar-r-12', ->
					div class: 'header-line', ->
						div 'Stats'

					div class: 'box', ->
						div class: "highlight pad-12 pad-b-4 split-lr", ->
							div "Status:"
							div "#{@status_str}"
                        div class: "highlight pad-l-12 pad-r-12 pad-b-4 split-lr", ->
                            div "Bytes:"
                            div "#{@bytes}"
						div class: "highlight pad-l-12 pad-r-12 pad-t-4 pad-b-4 split-lr", ->
							div "User:"
							div "#{@username}"
						div class: "highlight pad-l-12 pad-r-12 pad-t-4 pad-b-4 split-lr", ->
							div "Problem:"
							a href: (@url_for 'problem.description', { problem_name: @problem.short_name }), "#{@problem.name}"
						div class: 'hightlight pad-l-12 pad-r-12 pad-t-4 pad-b-4 split-lr', ->
							div "Time limit:"
							div "#{@problem.time_limit}ms"
						div class: "highlight pad-l-12 pad-r-12 pad-t-4 pad-b-4 split-lr", ->
							div "Time submittted:"
							div "#{ os.date '%c', @time_started }"
			div ->
				if @show_slash
					div class: 'header-line', ->
						div 'Test cases'

					div class: 'box', ->
						return unless type(@json_data) == "table"

						for i = 1, @json_data.total
							tc_status = 'primary'
							if i <= @json_data.completed
								tc_status = 'success'
							if @ring_color == 'error' and i == @json_data.completed + 1
								tc_status = 'error'

							div class: "tabbed-split tab-24 #{tc_status}", ->
								span ''
								div class: 'highlight pad-12', ->
									div class: 'split-3', ->
										p "Test case: #{i}"
										if i <= @json_data.completed
											p "Correct!"
										elseif i == @json_data.completed + 1
											switch @job.status
												when Jobs.statuses.wrong_answer then p "Wrong answer"
												when Jobs.statuses.timed_out then p "Timed out"
												when Jobs.statuses.error then p "Execution error"
												when Jobs.statuses.running then p "Running"
										else
											p "------------"

										if type(@json_data.run_times[i]) == 'number'
											p "Run time: #{@json_data.run_times[i]}ms"
				else
					div class: 'header-line', ->
						div @message

					div class: 'box', ->
						return unless @job.data
						pre (process_str @job.data)
