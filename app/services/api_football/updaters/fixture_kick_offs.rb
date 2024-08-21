module ApiFootball
	module Updaters
		class FixtureKickOffs < ApplicationService

			def initialize(league:)
				@league = league
				@options = { league: league.api_football_id, next: 50 }
			end

			def call
				response = make_api_call

				return :no_response if response['response'].blank?

				check_kick_offs(response['response'])

				:success
			end

			private

			attr_reader :league, :options

			def check_kick_offs(response_elements)
				response_elements.each do |elem|
					fixture = Fixture.find_by(api_football_id: elem['fixture']['id'])
					fixture_api_response = FixtureApiResponse.find_or_create_by(fixture_id: fixture.id)
					fixture_api_response.update(pre_fixture: elem, fixture: fixture)
					fixture.update(kick_off: Time.parse(elem['fixture']['date']))
				end
			end

			def make_api_call
				ApiFootball::ApiFootballCall.new(endpoint: 'fixtures', options: options).make_api_call
			end
		end
	end
end
