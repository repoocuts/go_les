module PlayerSeasonCreatorHelper

	def create_player_season(player, team_season)
		return if player.nil?
		return if team_season.nil?
		return if player.player_seasons.where(team_season: team_season.id).exists?

		player_season = PlayerSeason.create(
			player_id: player.id,
			team_season_id: team_season.id,
			current_season: true,
		)
		create_attacking_stat(player_season:)
		create_defensive_stat(player_season:)
		create_discipline_stat(player_season:)
		Rails.logger.info "Made Player Season data for #{player.return_name} - #{team_season.name} - #{team_season.season.years}"
	end

	private

	def create_attacking_stat(player_season:)
		PlayerSeasons::AttackingStat.create(player_season:)
	end

	def create_defensive_stat(player_season:)
		PlayerSeasons::DefensiveStat.create(player_season:)
	end

	def create_discipline_stat(player_season:)
		PlayerSeasons::DisciplineStat.create(player_season:)
	end
end
