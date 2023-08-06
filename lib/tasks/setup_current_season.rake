namespace :setup_current_season do
  desc "Setup current season's data for teams and fixtures"
  task setup: :environment do
    league = League.find_by(name: 'Premier League')
    season = league.current_season
    ApiFootball::Creators::TeamCreator.new(league: league.api_football_id, season: season.start_date.year).create_team
    puts "Team numbers #{Team.count}"
    ApiFootball::Creators::TeamSeasonCreator.new.create_current_team_seasons(league:, season:)
    puts "TeamSeason numbers #{Team.count}"
    ApiFootball::Creators::FixtureCreator.new(options: { league: league.api_football_id, season: season.start_date.year }).create_fixture
    puts "Fixture numbers #{Fixture.count}"
  end
end
