import Competitions from require 'models'

=>
    unless @competition
        @write json: 'No active competition'

    current_time = os.time()
    start_time = @competition\get_start_time_num!

    unless start_time <= current_time
        @write render: 'competition.not_started'
