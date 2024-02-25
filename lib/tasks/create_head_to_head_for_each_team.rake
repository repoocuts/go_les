namespace :create_head_to_head_for_each_team do
	desc "Create HeadToHead object for each team in the league"
	task setup: :environment do
		leagues = League.all
		leagues.each do |league|
			teams = league.teams
			teams.each do |team|
				league_team_ids = league.teams.pluck(:id) - [team.id]
				league_team_ids.each do |league_team_id|
					HeadToHead.create(
						team_id: team.id,
						opponent_id: league_team_id,
						bookings_received: 0,
						conceded_against_opponent: 0,
						conceded_home: 0,
						conceded_away: 0,
						current_team_season_id: team.current_team_season.id,
						fixtures_played: 0,
						opponent_bookings: 0,
						opponent_reds: 0,
						reds_received: 0,
						scored_against_opponent: 0,
						scored_home: 0,
						scored_away: 0,
					)
				end
			end
		end
	end
end
