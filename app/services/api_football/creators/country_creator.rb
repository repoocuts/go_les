module ApiFootball
	module Creators
		class CountryCreator < ApplicationService

			COUNTRIES = %w[brazil england france germany italy portugal scotland spain].freeze

			def call
				countries = make_api_call['response']
				countries.each do |elem|
					if COUNTRIES.include?(elem['name'].downcase)
						country = create_from_response(elem)
						Rails.logger.info("Created #{country}")
						ObjectHandlingFailure.create(object_type: 'country', api_response_element: elem) if country.nil?
					end
				end

				Rails.logger.info("Created #{Country.count} countries")
			end

			private

			def make_api_call
				ApiFootball::ApiFootballCall.new(endpoint: 'countries', options: nil).make_api_call
			end

			def create_from_response(response_element)
				country_exists = Country.where(name: response_element['name']).any?

				Country.create(name: response_element['name'], code: response_element['code']) unless country_exists
			end
		end
	end
end
