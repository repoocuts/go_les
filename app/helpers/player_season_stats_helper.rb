module PlayerSeasonStatsHelper
	def sort_link(column:, label:, season_id:)
		if column == params[:column]
			link_to(label, team_path(season_id:, column: column, direction: next_direction))
		else
			link_to(label, team_path(season_id:, column: column, direction: 'desc'))
		end
	end

	def next_direction
		params[:direction] == 'asc' ? 'desc' : 'asc'
	end
end
