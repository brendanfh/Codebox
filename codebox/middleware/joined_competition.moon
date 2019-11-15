import Competitions, CompetitionUsers from require 'models'

=>
	@competition = Competitions\find short_name: @params.competition_name
	cu = CompetitionUsers\find user_id: @user.id, competition_id: @competition.id
	unless cu
		@write render: 'competition.join'
