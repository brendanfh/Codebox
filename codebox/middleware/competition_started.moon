import Competitions from require 'models'

{:time_to_number} = (require 'utils.time')!

=>
    @competition = Competitions\find active: true
    unless @competition
        @write json: 'No active competition'
    
    current_time = os.time()
    start_time = time_to_number @competition.start

    unless start_time <= current_time
        @write render: 'competition.not_started'