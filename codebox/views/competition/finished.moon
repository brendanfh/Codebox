html = require 'lapis.html'

class CompetitionFinished extends html.Widget
    content: =>
        h1 'Competition has ended'
        h3 style: 'text-align: center', -> text "Ended at #{@competition.end}"