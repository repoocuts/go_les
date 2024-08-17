namespace :head_to_heads do
	desc "backfill assists for completed fixtures"
	task update_fixture_ids: :environment do
		HeadToHead.all.each do |head_to_head|
			team_id = head_to_head.team_id
			opponent_team = Team.find(head_to_head.opponent_id)
			opponent_team_current_team_season = opponent_team.current_team_season
			current_season_fixture_one = Fixture.where(home_team_season_id: head_to_head.current_team_season_id, away_team_season_id: opponent_team_current_team_season.id).first
			current_season_fixture_two = Fixture.where(home_team_season_id: opponent_team_current_team_season.id, away_team_season_id: head_to_head.current_team_season_id).first
			if current_season_fixture_one && current_season_fixture_two
				current_season_fixture_ids = [current_season_fixture_one.id, current_season_fixture_two.id]
				home_for_team = Fixture.where(home_team_id: team_id, away_team_id: opponent_team.id)
				home_for_opponent = Fixture.where(home_team_id: opponent_team.id, away_team_id: team_id)
				ids = (home_for_team.pluck(:id) + home_for_opponent.pluck(:id)).sort
				head_to_head.update(current_season_fixture_ids: current_season_fixture_ids, fixture_ids: ids)
				if current_season_fixture_one.home_score.nil?
					ids.delete(current_season_fixture_one.id)
				end
				if current_season_fixture_two.home_score.nil?
					ids.delete(current_season_fixture_two.id)
				end
				head_to_head.update(fixtures_played: ids.length)
			end
		end
	end

	desc 'update player statistics'
	task update_player_statistics: :environment do
		HeadToHead.all.each do |head_to_head|
			team_season = TeamSeason.find(head_to_head.current_team_season_id)
			opponent_team_season = Team.find(head_to_head.opponent_id).current_team_season
			head_to_head.update(
				top_assist_player_season_id: team_season.top_assisting_player_season.id,
				opponent_top_assist_player_season_id: opponent_team_season.top_assisting_player_season.id,
				top_scorer_player_season_id: team_season.top_scorer_player_season.id,
				opponent_top_scorer_player_season_id: opponent_team_season.top_scorer_player_season.id
			)
		end
	end
end
