module ApplicationHelper
	include Pagy::Frontend
	include RoutesHelper

	def convert_datetime_long(time)
		time.strftime("%a %e %b %H:%M")
	end

	def convert_datetime_short(time)
		time.strftime("%d/%m/%y")
	end

	def true?(attribute)
		attribute == true
	end

	def false?(attribute)
		attribute == false
	end
end
