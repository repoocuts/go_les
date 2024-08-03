class ChartsController < ApplicationController
	include TeamPlayerChartHelper

	def team_player_season_goals
		team_season = TeamSeason.find(params[:team_season_id])

		# Eager load player_seasons and their associated players
		goals = team_season.goals.includes(player_season: :player)

		# Transform the hash
		transformed_goals = goals.each_with_object(Hash.new(0)) do |goal, new_hash|
			player_name = goal.player_season.return_name
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
			player_name = assist.player_season.return_name
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
			player_name = card.player_season.return_name
			new_hash[player_name] += 1
		end

		render json: transformed_yellow_cards.sort_by { |_, count| -count }.to_h
	end

	def team_goals_radar
		current_team_season = TeamSeason.find(params[:current_team_season_id])
		opponent_team_season = TeamSeason.find(params[:opponent_team_season_id])
		data = {
			labels: ['Scored', 'Home Scored', 'Away Scored', 'Home Conceded', 'Away Conceded', 'Conceded'],
			datasets: [
				{
					label: current_team_season.name,
					data: [
						current_team_season.goals_for.size,
						current_team_season.home_goals_scored_count,
						current_team_season.away_goals_scored_count,
						current_team_season.home_goals_conceded_count,
						current_team_season.away_goals_conceded_count,
						current_team_season.goals_against_number,
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
					label: opponent_team_season.name,
					data: [
						opponent_team_season.goals_for.size,
						opponent_team_season.home_goals_scored_count,
						opponent_team_season.away_goals_scored_count,
						opponent_team_season.home_goals_conceded_count,
						opponent_team_season.away_goals_conceded_count,
						opponent_team_season.goals_against_number,
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

	def team_cards_line_chart
		team_seasons = TeamSeason.where(id: [params[:current_team_season_id], params[:opponent_team_season_id]])

		render json: team_seasons.map { |team_season|
			{
				name: team_season.name,
				data: { "Home Bookings" => team_season.yellow_cards_stat.home || 0,
				        "Away Bookings" => team_season.yellow_cards_stat.away || 0,
				        "Total Bookings" => team_season.yellow_cards_count || 0,
				        "Reds" => team_season.red_card_count || 0
				}
			}
		}
	end

end
