namespace :update_goal_stats_objects do
	desc "Update GoalsScored and GoalsConceded stats"
	task update_goals_scored_stats: :environment do
		TeamSeason.all.each do |team_season|
			goals_scored_stat = team_season.goals_scored_stat || team_season.build_goals_scored_stat

			goals = team_season.goals
			home_goals = goals.where(is_home: true)
			away_goals = goals.where(is_home: nil)
			first_half_goals = goals.where(minute: 0..45)
			second_half_goals = goals.where(minute: 46..100)
			home_first_half_goals = first_half_goals.where(is_home: true)
			away_first_half_goals = first_half_goals.where(is_home: nil)
			home_second_half_goals = second_half_goals.where(is_home: true)
			away_second_half_goals = second_half_goals.where(is_home: nil)

			if goals_scored_stat.total != goals.count
				goals_scored_stat.update!(
					total: goals.count,
					home: home_goals.count,
					away: away_goals.count,
					first_half: first_half_goals.count,
					second_half: second_half_goals.count,
					home_first_half: home_first_half_goals.count,
					away_first_half: away_first_half_goals.count,
					home_second_half: home_second_half_goals.count,
					away_second_half: away_second_half_goals.count,
				)
			end
		end
	end

	task update_goals_conceded_stats: :environment do
		TeamSeason.all.each do |team_season|
			goals_conceded_stat = team_season.goals_conceded_stat || team_season.build_goals_conceded_stat
			completed_fixtures = team_season.completed_fixtures

			ids = completed_fixtures.pluck(:id)

			goals = Goal.where(fixture_id: ids)

			goals = goals.where.not(team_season_id: team_season.id)

			home_conceded = goals.where(is_home: nil)
			away_conceded = goals.where(is_home: true)
			first_half_goals = goals.where(minute: 0..45)
			second_half_goals = goals.where(minute: 46..100)
			home_first_half_goals = first_half_goals.where(is_home: nil)
			away_first_half_goals = first_half_goals.where(is_home: true)
			home_second_half_goals = second_half_goals.where(is_home: nil)
			away_second_half_goals = second_half_goals.where(is_home: true)

			if goals_conceded_stat.total != goals.count
				goals_conceded_stat.update!(
					total: goals.count,
					home: home_conceded.count,
					away: away_conceded.count,
					first_half: first_half_goals.count,
					second_half: second_half_goals.count,
					home_first_half: home_first_half_goals.count,
					away_first_half: away_first_half_goals.count,
					home_second_half: home_second_half_goals.count,
					away_second_half: away_second_half_goals.count,
				)
			end
		end
	end
end
