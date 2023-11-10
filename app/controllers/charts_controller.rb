class ChartsController < ApplicationController
	def team_player_season_goals
		team_season = TeamSeason.find(params[:team_season_id])

		# Eager load player_seasons and their associated players
		goals = team_season.goals.includes(player_season: :player)

		# Transform the hash
		transformed_goals = goals.each_with_object(Hash.new(0)) do |goal, new_hash|
			player_name = goal.player_season.get_player_name
			new_hash[player_name] += 1
		end

		render json: transformed_goals.sort_by { |_, count| -count }.to_h
	end

end
