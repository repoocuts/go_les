module RoutesHelper

	def next_match_opponent_path_by_team(team)
		country_league_team_path(team.country, team.league, team.current_team_season.next_fixture_opponent_team_object)
	end

	def team_path_by_team(team)
		country_league_team_path(team.country, team.league, team)
	end

	def player_path_by_team_and_player(team, player)
		country_league_team_player_path(team.country, team.league, team, player)
	end

	def player_path_by_season_team_and_player(season, team, player)
		country_league_season_team_player_path(team.country, team.league, season, team, player)
	end

	def fixture_path_by_team(team)
		country_league_season_fixture_path(team.country, team.league, team.current_team_season, team.current_team_season.previous_fixture)
	end

	def fixture_path_by_fixture(fixture)
		country_league_season_fixture_path(fixture.league.country_id, fixture.league, fixture.season, fixture)
	end

	def season_path_by_season(season)
		country_league_season_path(season.league.country, season.league, season)
	end

	def team_season_path_by_season_and_team(season, team)
		country_league_season_team_path(team.country, team.league, season, team)
	end

	def team_season_path_by_team_season(team_season)
		team_season = team_season[:team_season] if team_season.is_a? Hash
		country_league_season_team_path(team_season.team.country, team_season.team.league, team_season.season, team_season.team)
	end
end
