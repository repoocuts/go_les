namespace :add_data_for_current_seasons do
	desc "Setup current season's data for teams and fixtures"
	task setup: :environment do
		League.all.each do |league|
			season = league.current_season
			ApiFootball::Creators::TeamsCreator.new(league:, season:).call
			puts "Team numbers #{Team.count}"
			ApiFootball::Creators::FixtureCreator.new(league:, season:).call
			puts "Fixture numbers #{Fixture.count}"
		end
	end
end
