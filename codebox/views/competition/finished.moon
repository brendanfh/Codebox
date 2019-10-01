html = require 'lapis.html'

class CompetitionFinished extends html.Widget
    content: =>
        h1 'Competition has ended'
        h3 class: 'ta-center', -> text "Ended at #{@competition.end}"
