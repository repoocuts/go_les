namespace :update_player_season_defensive_stat do
	desc "Update the defensive stat for each player"
	task update_player_seasons: :environment do
		PlayerSeason.for_current_season.each do |player_season|
			player_name = player_season.return_name
			defensive_stat = player_season.defensive_stat
			team_season_id = player_season.team_season_id
			fixture_ids = Appearance.where(player_season_id: player_season.id).pluck(:fixture_id).uniq
			fixtures = Fixture.where(id: fixture_ids)
			clean_sheet_away = defensive_stat.clean_sheet_away
			clean_sheet_away_first_half = defensive_stat.clean_sheet_away_first_half
			clean_sheet_away_second_half = defensive_stat.clean_sheet_away_second_half
			clean_sheet_first_half = defensive_stat.clean_sheet_first_half
			clean_sheet_home = defensive_stat.clean_sheet_home
			clean_sheet_home_first_half = defensive_stat.clean_sheet_home_first_half
			clean_sheet_home_second_half = defensive_stat.clean_sheet_home_second_half
			clean_sheet_second_half = defensive_stat.clean_sheet_second_half
			clean_sheet_total = defensive_stat.clean_sheet_total
			conceded_away = defensive_stat.conceded_away
			conceded_away_first_half = defensive_stat.conceded_away_first_half
			conceded_away_second_half = defensive_stat.conceded_away_second_half
			conceded_first_half = defensive_stat.conceded_first_half
			conceded_home = defensive_stat.conceded_home
			conceded_home_first_half = defensive_stat.conceded_home_first_half
			conceded_home_second_half = defensive_stat.conceded_home_second_half
			conceded_second_half = defensive_stat.conceded_second_half
			conceded_total = defensive_stat.conceded_total

			fixtures.each do |fixture|
				home_team = fixture.home_team_season_id == team_season_id
				goals_conceded = 0
				first_half_goals_conceded = 0
				second_half_goals_conceded = 0

				fixture.goals.each do |goal|
					if goal.team_season_id != team_season_id
						# It's a conceded goal
						goals_conceded += 1
						if goal.minute < 46
							first_half_goals_conceded += 1
						else
							second_half_goals_conceded += 1
						end
					end
				end

				if home_team
					conceded_home += goals_conceded
					conceded_home_first_half += first_half_goals_conceded
					conceded_home_second_half += second_half_goals_conceded
				else
					conceded_away += goals_conceded
					conceded_away_first_half += first_half_goals_conceded
					conceded_away_second_half += second_half_goals_conceded
				end

				conceded_first_half += first_half_goals_conceded
				conceded_second_half += second_half_goals_conceded
				conceded_total += goals_conceded

				# Clean sheet checks
				if goals_conceded == 0
					clean_sheet_total += 1
					if home_team
						clean_sheet_home += 1
						clean_sheet_home_first_half += 1 if first_half_goals_conceded == 0
						clean_sheet_home_second_half += 1 if second_half_goals_conceded == 0
					else
						clean_sheet_away += 1
						clean_sheet_away_first_half += 1 if first_half_goals_conceded == 0
						clean_sheet_away_second_half += 1 if second_half_goals_conceded == 0
					end

					clean_sheet_first_half += 1 if first_half_goals_conceded == 0
					clean_sheet_second_half += 1 if second_half_goals_conceded == 0
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
