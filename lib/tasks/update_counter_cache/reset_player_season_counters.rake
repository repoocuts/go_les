namespace :reset_player_season_counters do
	task update: :environment do
		counter = ApiCallCount.first_or_create(count: 0)
		PlayerSeason.find_each do |team_season|
			PlayerSeason.reset_counters(team_season.id, :goals, :assists, :appearances)
		end
		counter.update(count: 0)
	end
end
