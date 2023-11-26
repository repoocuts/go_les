Rails.application.routes.draw do
  resources :assists

  root 'dashboards#index'
  
  resources :dashboards
  resources :cards
  resources :goals
  resources :appearances
  resources :player_seasons
  resources :players
  resources :fixtures
  resources :team_seasons
  resources :teams
  resources :seasons
  resources :leagues
  resources :countries

  get 'team_player_season_goals/:team_season_id', to: 'charts#team_player_season_goals', as: 'team_player_season_goals'
  get 'team_player_season_assists/:team_season_id', to: 'charts#team_player_season_assists', as: 'team_player_season_assists'
  get 'team_player_season_yellow_cards/:team_season_id', to: 'charts#team_player_season_yellow_cards', as: 'team_player_season_yellow_cards'
  get 'team_goals_radar/:current_team_season_id/:opponent_team_season_id', to: 'charts#team_goals_radar', as: 'team_goals_radar'
  get 'team_cards_line_chart/:current_team_season_id/:opponent_team_season_id', to: 'charts#team_cards_line_chart', as: 'team_cards_line_chart'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
