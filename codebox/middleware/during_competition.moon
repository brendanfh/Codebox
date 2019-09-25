import Competitions from require 'models'

=>
    @competition = Competitions\find active: true
    unless @competition
        @write json: 'No active competition'

    current_time = os.time()
    start_time = @competition\get_start_time_num!
    end_time = @competition\get_end_time_num!

    unless start_time <= current_time
        @write render: 'competition.not_started'
    unless current_time <= end_time
        @write render: 'competition.finished'
