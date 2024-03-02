module ApiFootball
  module Creators
    class TeamCreator
      include ApiFootball

      ENDPOINT = 'teams'
      #Initalizing this object to get teams for a league requires league: league_id and season: season_start_year as options
      #for England Premier League options are then { league: 39, season: choose_your_year }

      def create_team
        teams = call['response']
        teams.map { |elem| create_from_response(elem) }
      end

      private

      attr_reader :league_api_football_id

      def interpolate_endpoint
        base_uri + ENDPOINT
      end

      def create_from_response(response_element)
        league = League.find_by(api_football_id: options[:league])
        team = Team.where(api_football_id: response_element['team']['id']).any?
        if !team
          Team.create(
            acronym: response_element['team']['code'],
            api_football_id: response_element['team']['id'],
            league_id: league.id,
            country_id: league.country.id,
            name: response_element['team']['name']
          )
        end
      end
    end
  end
end
