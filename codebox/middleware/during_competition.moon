import Competitions from require 'models'

{:time_to_number} = (require 'utils.time')!

=>
    @competition = Competitions\find active: true
    unless @competition
        @write json: 'No active competition'
    
    current_time = os.time()
    start_time = time_to_number @competition.start
    end_time = time_to_number @competition.end

    unless start_time <= current_time
        @write '<h1>Competition has not begun</h1>'
    unless current_time <= end_time
        @write '<h1>Competition has ended</h1>'