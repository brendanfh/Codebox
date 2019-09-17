html = require 'lapis.html'

class CompetitionNotStarted extends html.Widget
    content: =>
        h1 'Competition has not started'

        h3 style: 'text-align: center', -> text "Starts at #{@competition.start}"