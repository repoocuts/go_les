namespace :update_kickoffs do
	desc "update kick offs for next seven days"
	task setup: :environment do
		count = 0
		League.all.each do |league|
			season = league.current_season
			fixtures = season.fixtures.next_seven_days
			fixtures.all.each do |fixture|
				response_kick_off = ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id }).call
				parsed_time = Time.parse(response_kick_off)
				fixture.update(kick_off: parsed_time) if fixture.kick_off != Time.parse(response_kick_off)
				puts "Fixture #{fixture.id} updated"
				count += 1
			end
		end
	end
end
