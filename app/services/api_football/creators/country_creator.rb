module ApiFootball
  module Creators
    class CountryCreator < ApplicationService
      def initialize(create_england:, create_all:)
        @create_england = create_england
        @create_all = create_all
      end

      def call
        create_england_only if create_england
        create_all_countries if create_all

        Rails.logger.info("Created #{Country.count} countries")
      end

      private

      attr_reader :create_england, :create_all

      def make_api_call
        ApiFootball::ApiFootballCall.new(endpoint: 'countries', options: nil).make_api_call
      end

      def create_from_response(response_element)
        country_exists = Country.where(name: response_element['name']).any?

        Country.create(name: response_element['name'], code: response_element['code']) unless country_exists
      end

      def create_england_only
        countries = make_api_call['response']
        countries.each do |elem|
          if elem['name'] == 'England'
            england = create_from_response(elem)
          end
          return :success if england

          object_handling_failure(elem) if england.nil?
        end
      end

      def create_all_countries
        countries = make_api_call['response']
        countries.each do |elem|
          country = create_from_response(elem)

          object_handling_failure(elem) if country.nil?
        end

        :success
      end

      def object_handling_failure(element)
        @object_handling_failure ||= ObjectHandlingFailure.create(object_type: 'country', api_response_element: element)
      end
    end
  end
end
