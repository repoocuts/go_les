namespace :reset_player_season_counters do
	task update: :environment do
		PlayerSeason.find_each do |team_season|
			PlayerSeason.reset_counters(team_season.id, :goals, :assists, :appearances)
		end
	end
end
