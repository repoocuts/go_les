class ChartsController < ApplicationController
	include TeamPlayerChartHelper
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

	def team_player_season_assists
		team_season = TeamSeason.find(params[:team_season_id])

		# Eager load player_seasons and their associated players
		assists = team_season.assists.includes(player_season: :player)

		# Transform the hash
		transformed_assists = assists.each_with_object(Hash.new(0)) do |assist, new_hash|
			player_name = assist.player_season.get_player_name
			new_hash[player_name] += 1
		end
		render json: transformed_assists.sort_by { |_, count| -count }.to_h
	end

	def team_player_season_yellow_cards
		team_season = TeamSeason.find(params[:team_season_id])

		# Eager load player_seasons and their associated players
		yellow_cards = team_season.yellow_cards.includes(player_season: :player)

		# Transform the hash
		transformed_yellow_cards = yellow_cards.each_with_object(Hash.new(0)) do |card, new_hash|
			player_name = card.player_season.get_player_name
			new_hash[player_name] += 1
		end
		render json: transformed_yellow_cards.sort_by { |_, count| -count }.to_h
	end

end
