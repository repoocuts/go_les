module TeamSeasonsHelper

	def fixture_home_or_away_string(fixture:, team_season:)
		TeamSeasons::IndividualFixtureDetails.new(fixture:, team_season:).home_or_away_identifier
	end
end
