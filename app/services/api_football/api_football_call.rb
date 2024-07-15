module ApiFootball
	class ApiFootballCall
		include HTTParty

		def initialize(endpoint:, options:)
			@endpoint = endpoint
			@options = options
		end

		def make_api_call
			Rails.logger.info "Making API call for #{query}}"
			HTTParty.get(query, headers: headers)
		end

		private

		attr_reader :endpoint, :options

		def base_uri
			'https://api-football-v1.p.rapidapi.com/v3/'
		end

		def headers
			{
				'Accept': '*/*',
				'x-rapidapi-host': 'api-football-v1.p.rapidapi.com',
				'x-rapidapi-key': ENV['RAPID_API_KEY']
			}
		end

		def query
			return interpolate_endpoint if options.blank?

			interpolate_endpoint + interpolate_options
		end

		def interpolate_endpoint
			base_uri + endpoint
		end

		def interpolate_options
			parameter_string = '?'
			options.map { |k, v| parameter_string += "#{k}=#{v}&" }
			parameter_string.chop
		end
	end
end
