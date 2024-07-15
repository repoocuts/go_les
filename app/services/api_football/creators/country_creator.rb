module ApiFootball
	module Creators
		class CountryCreator < ApplicationService

			COUNTRIES = %w[brazil england portugal spain mexico turkey].freeze

			def call
				countries = make_api_call['response']

				countries.each do |elem|
					country = create_from_response(elem)

					Rails.logger.info("Created #{country}")
					ObjectHandlingFailure.create(object_type: 'country', api_response_element: elem) if country.nil?
				end

				Rails.logger.info("Created #{Country.count} countries")
			end

			private

			def make_api_call
				ApiFootball::ApiFootballCall.new(endpoint: 'countries', options: nil).make_api_call
			end

			def create_from_response(response_element)
				country_name = response_element['name']
				country_exists = Country.where(name: country_name).any?
				formatted_name = country_name.downcase
				slug = formatted_name.split(' ').join('-')
				hidden = COUNTRIES.include?(formatted_name) ? false : true

				Country.create(name: country_name, code: response_element['code'], slug: slug, hidden: hidden, flag: response_element['flag']) unless country_exists
			end
		end
	end
end
