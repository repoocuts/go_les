module ApiFootball
	module Updaters
		class FixtureApiCall < ApplicationService

			def initialize(fixture:, options:)
				@fixture = fixture
				@options = options || {}
			end

			def call
				response = make_api_call

				return if response['response'][0]['lineups'].empty?

				fixture_api_response.update(finished_fixture: response['response'][0], fixture: fixture)

				:success
			end

			private

			attr_reader :fixture, :options

			def fixture_api_response
				@fixture_api_response ||= FixtureApiResponse.find_or_create_by(fixture_id: fixture.id)
			end

			def make_api_call
				ApiFootball::ApiFootballCall.new(endpoint: 'fixtures', options: options).make_api_call
			end
		end
	end
end
