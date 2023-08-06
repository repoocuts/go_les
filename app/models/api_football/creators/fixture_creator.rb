module ApiFootball
  module Creators
    class FixtureCreator
      include ApiFootball

      ENDPOINT = 'fixtures'

      def initialize(options: { league: league_api_football_id, season: season_start_date_year })
        @options = options
      end

      def create_fixture
        fixtures = call['response']
        fixtures.map { |elem| create_from_response(elem) }
      end

      def create_old_fixture
        fixtures = call['response']
        fixtures.map { |elem| create_old_from_response(elem) }
      end

      private

      attr_reader :league_api_football_id

      def interpolate_endpoint
        base_uri + ENDPOINT
      end

      def create_from_response(response_element)
        league = League.first
        season = league.current_season
        Fixture.create(
          api_football_id: response_element['fixture']['id'],
          away_team_season_id: get_current_away_team_season_id(response_element['teams']['away']),
          home_team_season_id: get_current_home_team_season_id(response_element['teams']['home']),
          kick_off: response_element['fixture']['date'],
          league_id: league.id,
          season_id: season.id,
          game_week: response_element['league']['round'].split('-').last.strip.to_i,
        )
      end

      def get_current_home_team_season_id(response_home_team_element)
        team = Team.find_by(api_football_id: response_home_team_element['id'])
        team.team_seasons.where(current_season: true).first.id
      end

      def get_current_away_team_season_id(response_away_team_element)
        team = Team.find_by(api_football_id: response_away_team_element['id'])
        team.team_seasons.where(current_season: true).first.id
      end

      def create_old_from_response(response_element)
        league = League.first
        season = league.last_season
        Fixture.create(
          api_football_id: response_element['fixture']['id'],
          away_team_season_id: get_old_away_team_season_id(response_element['teams']['away']),
          home_team_season_id: get_old_home_team_season_id(response_element['teams']['home']),
          kick_off: response_element['fixture']['date'],
          league_id: league.id,
          season_id: season.id,
          away_score: response_element['score']['fulltime']['away'],
          game_week: response_element['league']['round'].split('-').last.strip.to_i,
          home_score: response_element['score']['fulltime']['home'],
        )
      end

      def get_old_home_team_season_id(response_home_team_element)
        team = Team.find_by(api_football_id: response_home_team_element['id'])
        team.team_seasons.first.id
      end

      def get_old_away_team_season_id(response_away_team_element)
        team = Team.find_by(api_football_id: response_away_team_element['id'])
        team.team_seasons.first.id
      end
    end
  end
end
