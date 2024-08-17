module GoalCreatorHelper

	ONE = 1.freeze

	def create_goal_from_api_data(event, fixture, team_season)
		case fixture.home_team_season == team_season
		when true
			event['detail'] == 'Own Goal' ? own_goal_for_home(event, fixture, team_season) : goal_for_home(event, fixture, team_season)
		else
			event['detail'] == 'Own Goal' ? own_goal_for_away(event, fixture, team_season) : goal_for_away(event, fixture, team_season)
		end
	end

	private

	def goal_for_home(event, fixture, team_season)
		scorer_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
		home_start = fixture.appearances.find_by(player_season: scorer_player_season)

		if scorer_player_season && home_start
			handle_goal(fixture, home_start, event, scorer_player_season, team_season, true)
		else
			ObjectHandlingFailure.create(object_type: 'goal', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
		end
	end

	def goal_for_away(event, fixture, team_season)
		scorer_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
		away_start = fixture.appearances.find_by(player_season: scorer_player_season)

		if scorer_player_season && away_start
			handle_goal(fixture, away_start, event, scorer_player_season, team_season, nil)
		else
			ObjectHandlingFailure.create(object_type: 'goal', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
		end
	end

	def own_goal_for_home(event, fixture, team_season)
		scorer_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
		away_start = fixture.appearances.find_by(player_season: scorer_player_season)
		if scorer_player_season && away_start
			Goal.create(
				appearance_id: away_start.id,
				fixture_id: fixture.id,
				minute: event['time']['elapsed'],
				own_goal: true,
				is_home: true,
				player_season_id: scorer_player_season.id,
				team_season_id: team_season.id,
				referee_fixture_id: fixture.referee_fixture&.id,
			)
			update_goals_stat(team_season, event['time']['elapsed'], team_type: 'home', stat_type: 'scored')
			update_goals_stat(fixture.away_team_season, event['time']['elapsed'], team_type: 'away', stat_type: 'conceded')
		else
			ObjectHandlingFailure.create(object_type: 'goal', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
		end
	end

	def own_goal_for_away(event, fixture, team_season)
		scorer_player_season = Player.find_by_api_football_id(event['player']['id']).current_player_season
		home_start = fixture.appearances.find_by(player_season: scorer_player_season)
		if scorer_player_season && home_start
			Goal.create(
				fixture_id: fixture.id,
				appearance_id: home_start.id,
				minute: event['time']['elapsed'],
				is_home: true,
				own_goal: true,
				player_season_id: scorer_player_season.id,
				team_season_id: team_season.id,
				referee_fixture_id: fixture.referee_fixture&.id,
			)
			update_goals_stat(team_season, event['time']['elapsed'], team_type: 'away', stat_type: 'scored')
			update_goals_stat(fixture.home_team_season, event['time']['elapsed'], team_type: 'home', stat_type: 'conceded')
		else
			ObjectHandlingFailure.create(object_type: 'goal', api_response_element: event, related_team_season_id: team_season.id, related_fixture_id: fixture.id)
		end
	end

	def handle_goal(fixture, appearance, event, scorer_player_season, team_season, is_home)
		goal = create_goal(fixture, appearance, event['type'], is_home, event['time']['elapsed'], scorer_player_season, team_season)
		if is_home
			update_goals_stats_for_home_score(team_season, fixture, event)
		else
			update_goals_stats_for_away_score(team_season, fixture, event)
		end
		if event['assist']['id'].present?
			handle_assist(goal, event, fixture, team_season)
		end
		update_player_season_attacking_stat_goal(scorer_player_season.attacking_stat, goal)
	end

	def handle_assist(goal, event, fixture, team_season)
		assist_player_season = Player.find_by_api_football_id(event['assist']['id']).current_player_season
		assist_appearance = fixture.appearances.find_by(player_season: assist_player_season)
		assist = create_assist(goal, assist_appearance, fixture, team_season, event['time']['elapsed'], true) if assist_appearance

		update_player_season_attacking_stat_assist(assist_player_season.attacking_stat, assist) if assist

		ObjectHandlingFailure.create(object_type: 'assist', api_response_element: event['assist'], related_team_season_id: team_season.id, related_fixture_id: fixture.id) unless assist_appearance
	end

	def create_goal(fixture, appearance, goal_type, is_home, minute, scorer_player_season, team_season)
		Goal.create(
			fixture_id: fixture.id,
			appearance_id: appearance.id,
			goal_type: goal_type.downcase,
			is_home: is_home,
			minute: minute,
			player_season_id: scorer_player_season.id,
			team_season_id: team_season.id,
			referee_fixture_id: fixture.referee_fixture&.id,
		)
	end

	def create_assist(goal, appearance, fixture, team_season, minute, is_home)
		Assist.create(
			goal: goal,
			appearance: appearance,
			fixture: fixture,
			team_season: team_season,
			player_season: appearance.player_season,
			minute: minute,
			is_home: is_home
		)
	end

	def update_goals_stats_for_home_score(team_season, fixture, event)
		update_goals_stat(team_season, event['time']['elapsed'], team_type: 'home', stat_type: 'scored')
		update_goals_stat(fixture.away_team_season, event['time']['elapsed'], team_type: 'away', stat_type: 'conceded')
	end

	def update_goals_stats_for_away_score(team_season, fixture, event)
		update_goals_stat(team_season, event['time']['elapsed'], team_type: 'away', stat_type: 'scored')
		update_goals_stat(fixture.home_team_season, event['time']['elapsed'], team_type: 'home', stat_type: 'conceded')
	end

	def update_goals_stat(team_season, minute, team_type:, stat_type:)
		goals_stat = team_season.send("goals_#{stat_type}_stat")
		half_key = minute < 45 ? 'first_half' : 'second_half'
		# Increment the appropriate counters
		goals_stat.increment("#{half_key}")
		goals_stat.increment("#{team_type}_#{half_key}")
		goals_stat.increment("#{team_type}")
		goals_stat.increment(:total)

		goals_stat.save
	end

	def update_player_season_attacking_stat_goal(attacking_stat, goal)
		attacking_stat.increment(:scored_total)
		if goal.is_home
			attacking_stat.increment(:scored_home)
			if goal.minute < 45
				attacking_stat.increment(:scored_first_half)
				attacking_stat.increment(:scored_home_first_half)
			else
				attacking_stat.increment(:scored_second_half)
				attacking_stat.increment(:scored_home_second_half)
			end
		else
			attacking_stat.increment(:scored_away)
			if goal.minute < 45
				attacking_stat.increment(:scored_second_half)
				attacking_stat.increment(:scored_away_second_half)
			else
				attacking_stat.increment(:scored_first_half)
				attacking_stat.increment(:scored_away_first_half)
			end
		end
		attacking_stat.save
	end

	def update_player_season_attacking_stat_assist(attacking_stat, assist)
		attacking_stat.increment(:assists_total)
		if assist.is_home
			attacking_stat.increment(:assists_home)
			if assist.minute < 45
				attacking_stat.increment(:assists_first_half)
				attacking_stat.increment(:assists_home_first_half)
			else
				attacking_stat.increment(:assists_second_half)
				attacking_stat.increment(:assists_home_second_half)
			end
		else
			attacking_stat.increment(:assists_away)
			if assist.minute < 45
				attacking_stat.increment(:assists_second_half)
				attacking_stat.increment(:assists_away_second_half)
			else
				attacking_stat.increment(:assists_first_half)
				attacking_stat.increment(:assists_away_first_half)
			end
		end
		attacking_stat.save
	end
end
