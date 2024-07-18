module RoutesHelper

	def next_match_opponent_path(team)
		country_league_team_path(team.country, team.league, team.current_team_season.next_match_opponent_object)
	end

	def country_league_team_path_for(team)
		country_league_team_path(team.country, team.league, team)
	end

	def country_league_team_player_path_for(team, player)
		country_league_team_player_path(team.country, team.league, team, player)
	end

	def country_league_season_fixture_for(team)
		country_league_season_fixture_path(team.country, team.league, team.current_team_season, team.current_team_season.last_match)
	end
end
