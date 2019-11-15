import Competitions from require 'models'

=>
    unless @competition
		@competition = Competitions\find short_name: @params.competition_name

		unless @competition
			@write json: 'Could not find competition'

    current_time = os.time()
    start_time = @competition\get_start_time_num!

    unless start_time <= current_time
        @write render: 'competition.not_started'
