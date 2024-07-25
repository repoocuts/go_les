class ApplicationController < ActionController::Base
	include Clearance::Controller
	include Pagy::Backend

	before_action :set_time_zone

	private

	def set_time_zone
		timezone = cookies[:timezone] || 'UTC' # Default to UTC if timezone is not set
		Time.zone = timezone
	end
end
