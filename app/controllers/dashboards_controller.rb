class DashboardsController < ApplicationController

	before_action :set_season

	def index
		if season
			@current_game_week = Fixture.where(season: season, game_week: season.current_game_week).order(:kick_off)
			@next_game_week = Fixture.where(season: season, game_week: season.current_game_week + 1).order(:kick_off)
			@pagy_scorers, @top_scorers = pagy_array(top_scorers)
			@pagy_assists, @top_assists = pagy_array(top_assists)
			@pagy_booked, @most_booked = pagy_array(top_booked)
		end

		respond_to do |format|
			format.html
			format.turbo_stream
		end
	end

	private

	attr_reader :season

	def set_season
		@season ||= Season.find_by(current_season: true)
	end

	def top_scorers_array
		Goal.by_season(season.id)
	end

	def top_assists_array
		Assist.by_season(season.id)
	end

	def top_scorers
		top_scorers_array.map do |player_season_id, goal_count|
			player_season = PlayerSeason.find(player_season_id)
			{
				player: player_season.get_player_name,
				team_acronym: player_season.team_acronym,
				team_name: player_season.team_name,
				goals: goal_count,
				player_id: player_season.player_id,
				team_id: player_season.team_season.team_id,
			}
		end
	end

	def top_assists
		top_assists_array.map do |player_season_id, assist_count|
			player_season = PlayerSeason.find(player_season_id)
			{
				player: player_season.get_player_name,
				team_acronym: player_season.team_acronym,
				team_name: player_season.team_name,
				assists: assist_count,
				player_id: player_season.player_id,
				team_id: player_season.team_season.team_id,
			}
		end
	end

	def top_booked_array
		Card.by_season(season.id)
	end

	def top_booked
		top_booked_array.map do |player_season_id, card_count|
			player_season = PlayerSeason.find(player_season_id)
			{
				player: player_season.get_player_name,
				team_acronym: player_season.team_acronym,
				team_name: player_season.team_name,
				yellow_cards: card_count,
				player_id: player_season.player_id,
				team_id: player_season.team_season.team_id,
			}
		end
	end
end
