namespace :update_kickoffs do
	desc "update kick offs for next seven days"
	task setup: :environment do
		counter = ApiCallCount.first_or_create(count: 0)

		League.not_hidden.each do |league|
			season = league.current_season
			fixtures = season.fixtures.next_seven_days
			count_required = fixtures.count
			puts "Counter count is #{counter.count}"
			puts "Required count is #{count_required}"
			if counter.can_make_api_call?(count_required)
				fixtures.all.each do |fixture|
					counter.increment_count
					response = ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id }).call
					sleep 3
					parsed_time = Time.parse(response['fixture']['date'])
					fixture.update(kick_off: parsed_time) if fixture.kick_off != parsed_time
					puts "Fixture #{fixture.id} updated"
				end
			end
		end
	end
end
