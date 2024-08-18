module RoutesHelper

	def next_match_opponent_path_by_team(team)
		country_league_team_path(team.country, team.league, team.current_team_season.next_fixture_opponent_team_object)
	end

	def team_path_by_team(team)
		country_league_team_path(team.country, team.league, team)
	end

	def player_sorting_path(team:, season_id:, column:, direction:)
		country_league_team_path(team.country, team.league, team, season_id: season_id, column: column, direction: direction)
	end

	def player_path_by_player_season(player_season)
		player = player_season.player
		season = player_season.season
		team = player.team
		country_league_season_team_player_path(team.country, team.league, season, team, player)
	end

	def player_path_by_team_and_player(team, player)
		country_league_team_player_path(team.country, team.league, team, player)
	end

	def player_path_by_season_team_and_player(season, team, player)
		country_league_season_team_player_path(team.country, team.league, season, team, player)
	end

	def fixture_path_by_fixture(fixture)
		season = fixture.season
		league = fixture.league
		country = fixture.league.country
		country_league_season_fixture_path(country, league, season, fixture)
	end

	def season_path_by_season(season)
		country_league_season_path(season.league.country, season.league, season)
	end

	def team_season_path_by_season_and_team(season, team)
		country_league_season_team_path(team.country, team.league, season, team)
	end

	def team_season_path_by_team_season(team_season)
		team_season = team_season[:team_season] if team_season.is_a? Hash
		team = team_season.team
		season = team_season.season
		league = team_season.team.league
		country = team_season.team.country
		country_league_season_team_path(country, league, season, team)
	end

	def team_season_path_by_player_season(player_season)
		team = player_season.team_season.team
		season = player_season.season
		league = team.league
		country = team.country
		country_league_season_team_path(country, league, season, team)
	end

	def league_path_by_league(league)
		country_league_path(league.country, league)
	end
end
