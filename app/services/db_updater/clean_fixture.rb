module DbUpdater
	class CleanFixture

		def initialize(fixture:)
			@fixture = fixture
		end

		def call
			destroy_fixture_appearances
			fixture.update(home_score: nil)
			clean_team_season_data_objects
			ApiFootball::Updaters::UpdateFromDbObject.new(fixture: fixture).call
		end

		private

		attr_reader :fixture

		def clean_team_season_data_objects
			clean_home_team_season_data(fixture.home_team_season)
			clean_away_team_season_data(fixture.away_team_season)
		end

		def clean_home_team_season_data(home_team_season)
			clean_goals_conceded_stat(home_team_season)
			clean_goals_scored_stat(home_team_season)
			clean_yellow_cards_stat(home_team_season)
			clean_red_cards_stat(home_team_season)
		end

		def clean_away_team_season_data(away_team_season)
			clean_goals_conceded_stat(away_team_season)
			clean_goals_scored_stat(away_team_season)
			clean_yellow_cards_stat(away_team_season)
			clean_red_cards_stat(away_team_season)
		end

		def destroy_fixture_appearances
			fixture.appearances.destroy_all
		end

		def clean_goals_conceded_stat(team_season)
			goals_conceded_stat = team_season.goals_conceded_stat
			goals_conceded_stat.update(
				first_half: team_season.first_half_goals_conceded_count,
				second_half: team_season.second_half_goals_conceded_count,
				home: team_season.home_goals_conceded_count,
				home_first_half: team_season.first_half_home_goals_conceded,
				home_second_half: team_season.second_half_home_goals_conceded,
				away: team_season.away_goals_conceded_count,
				away_first_half: team_season.first_half_away_goals_conceded,
				away_second_half: team_season.second_half_away_goals_conceded,
				total: team_season.goals_against_number,
			)
		end

		def clean_goals_scored_stat(team_season)
			goals_scored_stat = team_season.goals_scored_stat
			goals_scored_stat.update(
				first_half: team_season.first_half_goals_total,
				second_half: team_season.second_half_goals_total,
				home: team_season.home_goals_scored_count,
				home_first_half: team_season.home_first_half_goals_count,
				home_second_half: team_season.home_second_half_goals_count,
				away: team_season.away_goals_scored_count,
				away_first_half: team_season.away_first_half_goals_count,
				away_second_half: team_season.away_second_half_goals_count,
				total: team_season.goals_against_number,
			)
		end

		def clean_yellow_cards_stat(team_season)
			yellow_cards_stat = team_season.yellow_cards_stat
			yellow_cards_stat.update(
				first_half: team_season.first_half_yellow_cards_total,
				second_half: team_season.second_half_yellow_cards_total,
				home: team_season.home_yellow_cards,
				home_first_half: team_season.yellow_cards.where("minute < ? AND is_home = ?", 46, true).count,
				home_second_half: team_season.yellow_cards.where("minute > ? AND is_home = ?", 45, true).count,
				away: team_season.away_yellow_cards,
				away_first_half: team_season.yellow_cards.where("minute < ? AND is_home IS NULL", 46).count,
				away_second_half: team_season.yellow_cards.where("minute > ? AND is_home IS NULL", 45).count,
				total: team_season.yellow_card_count,
			)
		end

		def clean_red_cards_stat(team_season)
			red_cards_stat = team_season.red_cards_stat
			red_cards_stat.update(
				first_half: team_season.first_half_red_cards_total,
				second_half: team_season.second_half_red_cards_total,
				home: team_season.home_red_cards,
				home_first_half: team_season.red_cards.where("minute < ? AND is_home = ?", 46, true).count,
				home_second_half: team_season.red_cards.where("minute > ? AND is_home = ?", 45, true).count,
				away: team_season.away_red_cards,
				away_first_half: team_season.red_cards.where("minute < ? AND is_home IS NULL", 46).count,
				away_second_half: team_season.red_cards.where("minute > ? AND is_home IS NULL", 45).count,
				total: team_season.red_card_count,
			)
		end

		def object_handling_failure
			ObjectHandlingFailure.create(object_type: 'fixture', related_fixture_id: fixture.id)
		end
	end
end
