module ApplicationHelper
	include Pagy::Frontend

	def convert_datetime_long(time)
		time.strftime("%a %e %b %H:%M")
	end

	def convert_datetime_short(time)
		time.strftime("%d/%m/%y")
	end

end
