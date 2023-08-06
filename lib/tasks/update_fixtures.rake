namespace :update_fixtures do
  desc "Create appearances, goals and cards for a fixture"
  task setup: :environment do
    count = 0
    Fixture.all.each do |fixture|
      if !fixture.appearances.any?
        if count != 10
          ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id } ).update_fixture
          count += 1
          puts "Count = #{count}"
          puts "Fixture #{fixture.id} updated"
          sleep 3
        else
          sleep 10
          ApiFootball::Updaters::FixtureApiCall.new(fixture: fixture, options: { id: fixture.api_football_id } ).update_fixture
          count = 0
          puts "Fixture #{fixture.id} updated"
        end
      end
    end
  end
end
