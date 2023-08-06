module ApiFootball
  module Updaters
    class FixtureApiCall
      include ApiFootball
      include CheckPlayerExists
  
      ENDPOINT = 'fixtures'

      def initialize(fixture:, options:)
        @fixture = fixture
        @options = options || {}
      end

      def update_fixture
        response = call

        return if response['response'][0]['lineups'].empty?

        api_match_object = response['response'][0]

        verify_data(api_match_object['lineups'], fixture)

        parse_lineups(api_match_object['lineups'], fixture)

        parse_events(api_match_object['events'], fixture)
        
        update_fulltime_score(api_match_object['score']['fulltime'], fixture)
      end

      private

      attr_reader :fixture, :options

      def interpolate_endpoint
        base_uri + ENDPOINT
      end

      def parse_lineups(lineups, fixture)
        home_team_api_object = lineups[0]['startXI']
        away_team_api_object = lineups[1]['startXI']

        updater_fixture_home_starts(home_team_api_object, fixture)
        updater_fixture_away_starts(away_team_api_object, fixture)
      end

      def parse_events(events, fixture)
        sorted_events = events.sort_by do |obj|
          extra_time = obj['time']['extra']
          elapsed_time = obj['time']['elapsed']
          # If extra_time is nil, it will be sorted as 0, otherwise it will be sorted by its value
          [elapsed_time, extra_time || 0]
        end
        ApiFootball::Updaters::FixtureEvents.new.create_fixture_events(sorted_events, fixture)  
      end

      def updater_fixture_home_starts(home_team_api_object, fixture)
        ApiFootball::Updaters::FixtureHomeStarts.new.update_fixture_home_starts(home_team_api_object, fixture)
      end

      def updater_fixture_away_starts(away_team_api_object, fixture)
        ApiFootball::Updaters::FixtureAwayStarts.new.update_fixture_away_starts(away_team_api_object, fixture)
      end

      def update_fulltime_score(scores, fixture)
        fixture.update(home_score: scores['home'], away_score: scores['away'])
      end
    end
  end
end
