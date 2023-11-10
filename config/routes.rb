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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
