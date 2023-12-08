module Search
	extend ActiveSupport::Concern

	def return_teams(query)
		Team.where('name ILIKE ?', "%#{query}%")
	end

	def return_players(query)
		Player.where('full_name ILIKE ? OR short_name ILIKE ?', "%#{query}%", "%#{query}%")
	end
end