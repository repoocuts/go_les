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

	def radar_chart_thingy
		current_team_season = TeamSeason.find(params[:current_team_season_id])
		opponent_team_season = TeamSeason.find(params[:opponent_team_season_id])
		data = {
			labels: ['Scored', 'Home Scored', 'Away Scored', 'Home Conceded', 'Away Conceded', 'Conceded', 'Home Bookings', 'Away Bookings', 'Bookings', 'Reds'],
			datasets: [
				{
					label: current_team_season.team_name,
					data: [
						current_team_season.goals_for.size,
						current_team_season.home_goals_scored.size,
						current_team_season.away_goals_scored.size,
						current_team_season.home_goals_conceded_count,
						current_team_season.away_goals_conceded_count,
						current_team_season.goals_against_number,
						current_team_season.home_yellow_cards.size,
						current_team_season.away_yellow_cards.size,
						current_team_season.yellow_cards_count,
						current_team_season.red_card_count
					],
					fill: true,
					backgroundColor: 'rgba(255, 99, 132, 0.2)',
					borderColor: 'rgb(255, 99, 132)',
					pointBackgroundColor: 'rgb(255, 99, 132)',
					pointBorderColor: '#fff',
					pointHoverBackgroundColor: '#fff',
					pointHoverBorderColor: 'rgb(255, 99, 132)'
				},
				{
					label: opponent_team_season.team_name,
					data: [
						opponent_team_season.goals_for.size,
						opponent_team_season.home_goals_scored.size,
						opponent_team_season.away_goals_scored.size,
						opponent_team_season.home_goals_conceded_count,
						opponent_team_season.away_goals_conceded_count,
						opponent_team_season.goals_against_number,
						opponent_team_season.home_yellow_cards.size,
						opponent_team_season.away_yellow_cards.size,
						opponent_team_season.yellow_cards_count,
						opponent_team_season.red_card_count
					],
					fill: true,
					backgroundColor: 'rgba(54, 162, 235, 0.2)',
					borderColor: 'rgb(54, 162, 235)',
					pointBackgroundColor: 'rgb(54, 162, 235)',
					pointBorderColor: '#fff',
					pointHoverBackgroundColor: '#fff',
					pointHoverBorderColor: 'rgb(54, 162, 235)'
				}
			]
		}

		render json: data
	end

end
