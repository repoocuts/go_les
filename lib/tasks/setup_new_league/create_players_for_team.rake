namespace :create_players_for_team do
	desc "Setup players and player_seasons for a team"
	task setup: :environment do
		League.all.each do |league|
			league.teams.each do |team|
				ApiFootball::Creators::PlayerCreator.new(team:).call
			end
		end
	end
end
