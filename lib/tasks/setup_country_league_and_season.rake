namespace :setup_country_league_and_season do
  desc "Setup country league, last and current season"
  task setup: :environment do
    ApiFootball::Creators::CountryCreator.new(create_england:, create_all:).call
    puts "Created #{Country.first.name}"
    ApiFootball::Creators::LeagueCreator.new(create_premier_league:, create_all:).call
    puts "Created #{League.first.name}"
    league = League.first
    ApiFootball::Creators::SeasonCreator.new.create_last_season(league)
    ApiFootball::Creators::SeasonCreator.new.create_current_season(league)
  end
end
