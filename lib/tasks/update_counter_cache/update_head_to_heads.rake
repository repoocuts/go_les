namespace :update_head_to_head_objects do
	desc "Update head_to_head objects"
	task update_h_to_h: :environment do
		count = HeadToHead.all.size
		puts "Starting with #{count} head to heads"
		HeadToHead.all.each do |head_to_head|
			team = Team.find(head_to_head.team_id)
			opponent = Team.find(head_to_head.opponent_id)
			puts "Updating #{team.name} vs #{opponent.name}"
			team_season_ids = team.team_seasons.pluck(:id)
			opponent_team_season_ids = opponent.team_seasons.pluck(:id)

			# setup fixture data
			fixtures = team.fixtures.where("home_team_id = #{opponent.id} OR away_team_id = #{opponent.id}")
			fixture_ids = fixtures.pluck(:id).uniq
			current_season_fixture_ids = fixtures.where("home_team_season_id = #{head_to_head.current_team_season_id} OR away_team_season_id = #{head_to_head.current_team_season_id}").pluck(:id)
			fixtures_played = fixtures.where.not(home_score: nil).size
			last_match_id = fixtures.where.not(home_score: nil).order(:kick_off).last&.id

			# set up goal scored data
			goals_scored = Goal.where(fixture_id: fixture_ids, team_season_id: team_season_ids)
			scored_against_opponent = goals_scored.size
			scored_away = goals_scored.where(is_home: nil).size
			scored_home = goals_scored.where(is_home: true).size

			# setup goal conceded data
			goals_conceded = Goal.where(fixture_id: fixture_ids, team_season_id: opponent_team_season_ids)
			conceded_against_opponent = goals_conceded.size
			conceded_away = goals_conceded.where(is_home: true).size
			conceded_home = goals_conceded.where(is_home: nil).size

			# set up card received data
			team_cards = Card.where(fixture_id: fixture_ids, team_season_id: team_season_ids)
			bookings_received = team_cards.where(card_type: 'yellow').size
			reds_received = team_cards.where(card_type: 'red').size

			# set up cards for opponent data
			opponent_cards = Card.where(fixture_id: fixture_ids, team_season_id: opponent_team_season_ids)
			opponent_bookings = opponent_cards.where(card_type: 'yellow').size
			opponent_reds = opponent_cards.where(card_type: 'red').size

			# setup player id data
			opponent_top_assist_player_season_id = opponent.current_team_season.top_assisting_player_season.id
			opponent_top_scorer_player_season_id = opponent.current_team_season.top_scorer_player_season.id
			top_assist_player_season_id = team.current_team_season.top_assisting_player_season.id
			top_scorer_player_season_id = team.current_team_season.top_scorer_player_season.id

			new_attributes = {
				bookings_received: bookings_received,
				conceded_against_opponent: conceded_against_opponent,
				conceded_away: conceded_away,
				conceded_home: conceded_home,
				current_season_fixture_ids: current_season_fixture_ids,
				fixture_ids: fixture_ids,
				fixtures_played: fixtures_played,
				opponent_bookings: opponent_bookings,
				opponent_reds: opponent_reds,
				reds_received: reds_received,
				scored_against_opponent: scored_against_opponent,
				scored_away: scored_away,
				scored_home: scored_home,
				last_match_id: last_match_id,
				opponent_top_assist_player_season_id: opponent_top_assist_player_season_id,
				opponent_top_scorer_player_season_id: opponent_top_scorer_player_season_id,
				top_assist_player_season_id: top_assist_player_season_id,
				top_scorer_player_season_id: top_scorer_player_season_id,
			}

			if head_to_head.attributes != new_attributes
				puts "Saving as attributes changed #{new_attributes}"
				Rails.logger.info "Updating HeadToHead #{head_to_head.id}"
				head_to_head.update_columns(new_attributes)
			end
			count -= 1
			puts "#{count} remaining"
		end
	end
end
