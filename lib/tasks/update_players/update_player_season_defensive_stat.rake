namespace :update_player_season_defensive_stat do
	desc "Update the defensive stat for each player"
	task update_player_seasons: :environment do
		PlayerSeason.for_current_season.each do |player_season|
			player_name = player_season.return_name
			defensive_stat = player_season.defensive_stat
			team_season_id = player_season.team_season_id
			fixture_ids = Appearance.where(player_season_id: player_season.id).pluck(:fixture_id).uniq
			fixtures = Fixture.where(id: fixture_ids)
			clean_sheet_away = 0
			clean_sheet_away_first_half = 0
			clean_sheet_away_second_half = 0
			clean_sheet_first_half = 0
			clean_sheet_home = 0
			clean_sheet_home_first_half = 0
			clean_sheet_home_second_half = 0
			clean_sheet_second_half = 0
			clean_sheet_total = 0
			conceded_away = 0
			conceded_away_first_half = 0
			conceded_away_second_half = 0
			conceded_first_half = 0
			conceded_home = 0
			conceded_home_first_half = 0
			conceded_home_second_half = 0
			conceded_second_half = 0
			conceded_total = 0

			fixtures.each do |fixture|
				if fixture.home_team_season_id == team_season_id
					conceded_home += fixture.away_score
				else
					conceded_away += fixture.home_score
				end
				fixture.goals.each do |goal|
					if goal.minute < 45 && goal.is_home
					end
				end
				defensive_stat.update(
					clean_sheet_away: clean_sheet_away,
					clean_sheet_away_first_half: clean_sheet_away_first_half,
					clean_sheet_away_second_half: clean_sheet_away_second_half,
					clean_sheet_first_half: clean_sheet_first_half,
					clean_sheet_home: clean_sheet_home,
					clean_sheet_home_first_half: clean_sheet_home_first_half,
					clean_sheet_home_second_half: clean_sheet_home_second_half,
					clean_sheet_second_half: clean_sheet_second_half,
					clean_sheet_total: clean_sheet_total,
					conceded_away: conceded_away,
					conceded_away_first_half: conceded_away_first_half,
					conceded_away_second_half: conceded_away_second_half,
					conceded_first_half: conceded_first_half,
					conceded_home: conceded_home,
					conceded_home_first_half: conceded_home_first_half,
					conceded_home_second_half: conceded_home_second_half,
					conceded_second_half: conceded_second_half,
					conceded_total: conceded_total,
				)
			end
		end
	end
end
