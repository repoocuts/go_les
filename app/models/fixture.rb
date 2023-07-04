class Fixture < ApplicationRecord
  has_many :appearances
  has_many :goals
  has_many :cards

  belongs_to :season
  belongs_to :league

  def update_stats_post_match
    update_from_api_football_response
  end

  def update_home_starts
    updater_fixture_home_starts.update_fixture_home_starts(self)
  end

  def update_away_starts
    updater_fixture_away_starts.update_fixture_away_starts(self)
  end

  def home_team_season
    TeamSeason.find_by(id: home_team_season_id)
  end

  def away_team_season
    TeamSeason.find_by(id: away_team_season_id)
  end

  def home_team_api_football_id
    home_team_season.team.api_football_id
  end

  def away_team_api_football_id
    away_team_season.team.api_football_id
  end

  def home_team_name
    home_team_season.team.name
  end

  def away_team_name
    away_team_season.team.name
  end

  def format_kick_off
    kick_off.strftime("%m %b %H:%M")
  end

  def interpolate_final_score
    home_score.to_s + ' - ' + away_score.to_s
  end

  def opponent_for_team_season(team_season_id)
    return home_team_name if team_season_id == away_team_season_id

    away_team_name
  end

  def home_or_away_checker(team_season_id)
    return "H" if team_season_id == away_team_season_id

    "A"
  end

  def appearance_for_player_season(player_season_id)
    return appearances.where(player_season_id: player_season_id).first

    self
  end

  private

  def update_from_api_football_response
    Updaters::FixtureApiCall.new(fixture: self, options: {id: api_football_id}).update_fixture
  end
end
