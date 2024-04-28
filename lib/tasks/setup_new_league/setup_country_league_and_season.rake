namespace :setup_country_league_and_season do
	desc "Setup country league, last and current season"
	task setup: :environment do
		ApiFootball::Creators::CountryCreator.call
		ApiFootball::Creators::LeagueCreator.new.call
		League.all.each do |league|
			ApiFootball::Creators::SeasonCreator.new(league:).call
		end
	end
end
