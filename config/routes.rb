Rails.application.routes.draw do

	# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

	# Defines the root path route ("/")
	root 'dashboards#index'

	namespace :ceefax do
		resources :appearances
		resources :assists
		namespace :player_seasons do
			resources :attacking_stats
			resources :defensive_stats
			resources :discipline_stats
		end
		namespace :team_seasons do
			resources :goals_conceded_stats
			resources :goals_scored_stats
			resources :red_cards_stats
			resources :yellow_cards_stats
		end
		resources :cards
		resources :corners
		resources :countries
		resources :dashboards
		resources :fixtures
		resources :goals
		resources :head_to_heads
		resources :leagues
		resources :players
		resources :player_seasons
		resources :object_handling_failures
		resources :referees
		resources :referee_fixtures
		resources :seasons
		resources :season_game_weeks
		resources :teams
		resources :team_seasons

		root to: "dashboards#index"
	end

	resources :dashboards

	resources :countries do
		resources :leagues, only: [:index, :show, :update, :destroy] do
			resources :teams do
				resources :players, only: [:show, :update, :destroy]
			end
			resources :seasons, only: [:show, :update, :destroy] do
				member do
					get 'scorers_streaming'
					get 'assists_streaming'
					get 'bookings_streaming'
					get 'reds_streaming'
				end
				resources :player_seasons
				resources :fixtures
				resources :assists
				resources :cards
				resources :goals
				resources :referees, only: [:index, :show, :update, :destroy]
			end
		end
	end

	resources :discipline_stats
	resources :defensive_stats
	resources :attacking_stats
	resources :corners
	resources :head_to_heads
	resources :fixtures, only: [:index]
	resources :referee_fixtures
	resources :referees
	resources :goals_conceded_stats
	resources :goals_scored_stats
	resources :leagues, only: [:index]
	resources :players, only: [:index, :show, :update, :destroy]
	resources :team_seasons
	resources :teams, only: [:index, :show, :update, :destroy]

	get 'team_player_season_goals/:team_season_id', to: 'charts#team_player_season_goals', as: 'team_player_season_goals'
	get 'team_player_season_assists/:team_season_id', to: 'charts#team_player_season_assists', as: 'team_player_season_assists'
	get 'team_player_season_yellow_cards/:team_season_id', to: 'charts#team_player_season_yellow_cards', as: 'team_player_season_yellow_cards'
	get 'team_goals_radar/:current_team_season_id/:opponent_team_season_id', to: 'charts#team_goals_radar', as: 'team_goals_radar'
	get 'team_cards_line_chart/:current_team_season_id/:opponent_team_season_id', to: 'charts#team_cards_line_chart', as: 'team_cards_line_chart'
	get '/search', to: 'dashboards#search', as: 'search'
	get 'scorers_streaming', to: 'seasons#scorers_streaming'
	get 'assists_streaming', to: 'seasons#assists_streaming'
	get 'bookings_streaming', to: 'seasons#bookings_streaming'
	get 'reds_streaming', to: 'seasons#reds_streaming'

end
