namespace :update_player_season_stat_objects do
	desc "Update AttackingStat and DefensiveStat and DisciplineStat"
	task player_seasons_attacking_stat: :environment do
		PlayerSeason.for_current_season.each do |player_season|
			player_seasons_attacking_stat = player_season.player_seasons_attacking_stat || player_season.build_player_seasons_attacking_stat

			goals_count = player_season.season_goals_size
			assists_count = player_season.season_assists_size

			if player_seasons_attacking_stat.scored_total != goals_count ||
				player_seasons_attacking_stat.assists_total != assists_count
				player_seasons_attacking_stat.update!(
					scored_total: goals_count,
					scored_home: player_season.home_goals_count,
					scored_away: player_season.away_goals_count,
					scored_first_half: player_season.first_half_goals_count,
					scored_second_half: player_season.second_half_goals_count,
					scored_home_first_half: player_season.first_half_home_goals_count,
					scored_away_first_half: player_season.first_half_away_goals_count,
					scored_home_second_half: player_season.second_half_home_goals_count,
					scored_away_second_half: player_season.second_half_away_goals_count,
					assists_total: assists_count,
					assists_home: player_season.home_assists_count,
					assists_away: player_season.away_assists_count,
					assists_first_half: player_season.first_half_assists_count,
					assists_second_half: player_season.second_half_assists_count,
					assists_home_first_half: player_season.first_half_home_assists_count,
					assists_away_first_half: player_season.first_half_away_assists_count,
					assists_home_second_half: player_season.second_half_home_assists_count,
					assists_away_second_half: player_season.second_half_away_assists_count,
				)
			end
			puts "Updated #{player_season.return_name} player_seasons_attacking_stat"
		end
	end

	task player_seasons_defensive_stat: :environment do
		PlayerSeason.for_current_season.each do |player_season|
			player_seasons_defensive_stat = player_season.player_seasons_defensive_stat || player_season.build_player_seasons_defensive_stat

			goals_count = player_season.season_goals_size
			assists_count = player_season.season_assists_size

			if player_seasons_defensive_stat.scored_total != goals_count ||
				player_seasons_defensive_stat.assists_total != assists_count
				player_seasons_defensive_stat.update!(
					conceded_total: 0,
					conceded_home: 0,
					conceded_away: 0,
					conceded_first_half: 0,
					conceded_second_half: 0,
					conceded_home_first_half: 0,
					conceded_away_first_half: 0,
					conceded_home_second_half: 0,
					conceded_away_second_half: 0,
					clean_sheet_total: 0,
					clean_sheet_home: 0,
					clean_sheet_away: 0,
					clean_sheet_first_half: 0,
					clean_sheet_second_half: 0,
					clean_sheet_home_first_half: 0,
					clean_sheet_away_first_half: 0,
					clean_sheet_home_second_half: 0,
					clean_sheet_away_second_half: 0,
				)
			end
			puts "Updated #{player_season.return_name} player_seasons_attacking_stat"
		end
	end

end
