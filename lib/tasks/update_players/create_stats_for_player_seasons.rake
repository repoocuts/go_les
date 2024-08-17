namespace :create_stats_for_player_seasons do
	desc "Check player_seasons have all necessary objects"
	task setup: :environment do
		PlayerSeason.for_current_season.each do |player_season|
			player_name = player_season.return_name
			unless player_season.attacking_stat
				PlayerSeasons::AttackingStat.create(player_season:)
				puts "Created Attacking Stat for #{player_name}"
			end
			unless player_season.defensive_stat
				PlayerSeasons::DefensiveStat.create(player_season:)
				puts "Created Defensive Stat for #{player_name}"
			end
			unless player_season.discipline_stat
				PlayerSeasons::DisciplineStat.create(player_season:)
				puts "Created Discipline Stat for #{player_name}"
			end
		end
	end
end
