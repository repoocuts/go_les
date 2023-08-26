module ApiFootball
  module Updaters
    class FixtureHomeSubstitutions

      include PlayerSeasonCreatorHelper

      ENDPOINT = 'fixtures/events'

      def initialize(options)
        @options = options
      end

      def update_fixture_home_substitutions(fixture)
        create_home_substitutions(fixture)
      end

      private

      def interpolate_endpoint
        base_uri + ENDPOINT
      end

      def fixture_events_api_object
        call['response']
      end

      def check_player_objects_exist(api_object, fixture)
        api_object.each do |object|
          create_player_season(object['player']['id'], fixture.home_team_season.team_season)
        end
      end
      
      def create_home_substitutions(fixture)
        events = fixture_events_api_object
      end
    end
  end
end
