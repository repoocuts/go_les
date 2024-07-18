module DbUpdater
	class HeadToHeadUpdater

		FIXTURE_INCREMENT = 1

		def initialize(fixture:)
			@fixture = fixture
		end

		def call
			home_team_head_to_head_update
			away_team_head_to_head_update
		end

		private

		attr_reader :fixture

		def home_team_head_to_head
			@home_team_head_to_head ||= HeadToHead.find_by(team_id: fixture.home_team_season.team.id, opponent_id: fixture.away_team_season.team.id)
		end

		def away_team_head_to_head
			@away_team_head_to_head ||= HeadToHead.find_by(team_id: fixture.away_team_season.team.id, opponent_id: fixture.home_team_season.team.id)
		end

		def home_team_head_to_head_update
			home_team_head_to_head.update(
				bookings_received: home_team_bookings_received_increment,
				conceded_against_opponent: home_team_conceded_against_opponent_increment,
				conceded_home: home_team_conceded_home_increment,
				fixtures_played: fixtures_played_increment,
				opponent_bookings: home_team_opponent_bookings_increment,
				opponent_reds: home_team_opponent_reds_increment,
				reds_received: home_team_reds_received_increment,
				scored_against_opponent: home_team_scored_against_opponent_increment,
				scored_home: home_team_scored_home_increment,
				last_match_id: fixture.id,
			)
		end

		def away_team_head_to_head_update
			away_team_head_to_head.update(
				bookings_received: away_team_bookings_received_increment,
				conceded_against_opponent: away_team_conceded_against_opponent_increment,
				conceded_away: away_team_conceded_away_increment,
				fixtures_played: fixtures_played_increment,
				opponent_bookings: away_team_opponent_bookings_increment,
				opponent_reds: away_team_opponent_reds_increment,
				reds_received: away_team_reds_received_increment,
				scored_against_opponent: away_team_scored_against_opponent_increment,
				scored_away: away_team_scored_away_increment,
				last_match_id: fixture.id
			)
		end

		def home_team_bookings_received_increment
			home_team_head_to_head.bookings_received += home_yellow_cards_received
		end

		def away_team_bookings_received_increment
			away_team_head_to_head.bookings_received += away_yellow_cards_received
		end

		def home_team_conceded_against_opponent_increment
			home_team_head_to_head.conceded_against_opponent += away_goals_scored
		end

		def away_team_conceded_against_opponent_increment
			away_team_head_to_head.conceded_against_opponent += home_goals_scored
		end

		def home_team_conceded_home_increment
			home_team_head_to_head.conceded_home += away_goals_scored
		end

		def away_team_conceded_away_increment
			away_team_head_to_head.conceded_away += home_goals_scored
		end

		def home_team_opponent_bookings_increment
			home_team_head_to_head.opponent_bookings += away_yellow_cards_received
		end

		def away_team_opponent_bookings_increment
			away_team_head_to_head.opponent_bookings += home_yellow_cards_received
		end

		def home_team_opponent_reds_increment
			home_team_head_to_head.opponent_reds += away_red_cards_received
		end

		def away_team_opponent_reds_increment
			away_team_head_to_head.opponent_reds += home_red_cards_received
		end

		def home_team_reds_received_increment
			home_team_head_to_head.reds_received += home_red_cards_received
		end

		def away_team_reds_received_increment
			away_team_head_to_head.reds_received += away_red_cards_received
		end

		def home_team_scored_against_opponent_increment
			home_team_head_to_head.scored_against_opponent += home_goals_scored
		end

		def away_team_scored_against_opponent_increment
			away_team_head_to_head.scored_against_opponent += away_goals_scored
		end

		def home_team_scored_home_increment
			home_team_head_to_head.scored_home += home_goals_scored
		end

		def away_team_scored_away_increment
			away_team_head_to_head.scored_away += away_goals_scored
		end

		def home_goals_scored
			return 0 if fixture.home_score.nil?

			fixture.home_score
		end

		def away_goals_scored
			return 0 if fixture.away_score.nil?

			fixture.away_score
		end

		def home_yellow_cards_received
			fixture.home_yellow_cards.size || 0
		end

		def away_yellow_cards_received
			fixture.away_yellow_cards.size || 0
		end

		def home_red_cards_received
			fixture.home_red_cards.size || 0
		end

		def away_red_cards_received
			fixture.away_red_cards.size || 0
		end

		def fixtures_played_increment
			home_team_head_to_head.fixtures_played += 1
		end
	end
end
