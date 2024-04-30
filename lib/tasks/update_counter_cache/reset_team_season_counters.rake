namespace :reset_team_season_counters do
	task update: :environment do
		TeamSeason.find_each do |team_season|
			TeamSeason.reset_counters(team_season.id, :goals, :red_cards, :yellow_cards)
		end
	end
end
