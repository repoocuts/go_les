namespace :setup_country_league_and_season do
  desc "Setup country league, last and current season"
  task setup: :environment do
	  ApiFootball::Creators::CountryCreator.new.call
    puts "Created #{Country.first.name}"
    ApiFootball::Creators::LeagueCreator.new.create_premier_league
    puts "Created #{League.first.name}"
    league = League.first
    ApiFootball::Creators::SeasonCreator.new.create_last_season(league)
    ApiFootball::Creators::SeasonCreator.new.create_current_season(league)
  end
end
