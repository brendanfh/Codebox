html = require "lapis.html"

class Index extends html.Widget
	content: =>
		h1 style: "background-color:red", "Hello World!!!"
		p "Hello #{@user.nickname}, #{@user.username}, #{@user.email}!"
		p "The value is #{@val}"
		p "API: #{@api_test}"

		ul ->
			for job in *@jobs
				li "#{job.lang} - #{job.problem_id} - #{job\get_problem!.name}"

		ul ->
			for user in *@users
				if user.username == @user.username
					li style: "border: 2px solid yellow", "#{user.username} - #{user.email}"
				else
					li "#{user.username} - #{user.email}"
