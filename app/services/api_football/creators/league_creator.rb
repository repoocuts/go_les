module ApiFootball
  module Creators
    class LeagueCreator < ApplicationService

      def initialize(create_premier_league:, create_all:)
        @create_premier_league = create_premier_league
        @create_all = create_all
      end

      def call
        create_premier_league_only if create_premier_league
        create_all_leagues if create_all
      end

      private

      attr_reader :create_premier_league, :create_all

      def make_api_call
        ApiFootball::ApiFootballCall.new(endpoint: 'leagues', options: nil).make_api_call
      end

      def create_from_response(response_element)
        country = get_country(response_element['country']['name'])
        league = League.create(name: response_element['league']['name'], api_football_id: response_element['league']['id'], country_id: country.id)

        object_handling_failure(response_element['league']['name'], country.id) if league.nil?
      end

      def create_premier_league_only
        leagues = make_api_call['response']
        leagues.each do |elem|
          if elem['league']['name'] == 'Premier League' && elem['country']['name'] == 'England'
            premier_league = create_from_response(elem)

            return :success if premier_league
          end
        end
      end

      def create_all_leagues
        leagues = make_api_call['response']
        leagues.each do |elem|
          create_from_response(elem) unless League.where(name: elem['league']['name']).any?
        end

        :success
      end

      def get_country(country_name)
        Country.find_by(name: country_name)
      end

      def object_handling_failure(element, related_country_id)
        @object_handling_failure ||= ObjectHandlingFailure.create(object_type: 'league', api_response_element: element, related_country_id:)
      end
    end
  end
end
