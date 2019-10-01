html = require 'lapis.html'

class CompetitionNotStarted extends html.Widget
    content: =>
        h1 'Competition has not started'

        h3 class: 'ta-center', -> text "Starts at #{@competition.start}"
