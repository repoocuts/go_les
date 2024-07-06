module ApiFootball
	module Creators
		class TeamSeasonCreator < ApplicationService

			def initialize(team:, season:)
				@team = team
				@season = season
			end

			def call
				return if team.team_seasons.where(season_id: season.id).any?

				team_season = TeamSeason.create(team_id: team.id, season_id: season.id, current_season: true)
				create_association_objects(team_season)
				create_head_to_heads_for_team(team, team_season, season.league)
				Rails.logger.info "Team season creator for #{team.name} season #{season.years} succeeded"
			end

			private

			attr_reader :team, :season

			def create_association_objects(team_season)
				create_goals_conceded_stat(team_season)
				create_goals_scored_stat(team_season)
				create_red_cards_stat(team_season)
				create_yellow_cards_stat(team_season)
			end

			def create_goals_conceded_stat(team_season)
				TeamSeasons::GoalsConcededStat.create(team_season_id: team_season.id)
			end

			def create_goals_scored_stat(team_season)
				TeamSeasons::GoalsScoredStat.create(team_season_id: team_season.id)
			end

			def create_red_cards_stat(team_season)
				TeamSeasons::RedCardsStat.create(team_season_id: team_season.id)
			end

			def create_yellow_cards_stat(team_season)
				TeamSeasons::YellowCardsStat.create(team_season_id: team_season.id)
			end

			def create_head_to_heads_for_team(team, team_season, league)
				league.teams.where.not(id: team.id).each do |other_team|
					head_to_head = HeadToHead.find_by(team_id: team.id, opponent_id: other_team.id)

					create_head_to_head(team_id: team.id, opponent_id: other_team.id, current_team_season_id: team_season.id) unless head_to_head
					update_head_to_head(head_to_head, current_team_season_id: team_season.id) if head_to_head
				end
			end

			def create_head_to_head(team_id:, opponent_id:, current_team_season_id:)
				HeadToHead.create(team_id:, opponent_id:, current_team_season_id:)
			end

			def update_head_to_head(head_to_head, current_team_season_id:)
				head_to_head.update(current_team_season_id:)
			end
		end
	end
end
