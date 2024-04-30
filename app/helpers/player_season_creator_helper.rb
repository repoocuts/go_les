module PlayerSeasonCreatorHelper

	def create_player_season(player, team_season)
		PlayerSeason.create(
			player_id: player.id,
			team_season_id: team_season.id,
			current_season: true,
		)
	end
end
