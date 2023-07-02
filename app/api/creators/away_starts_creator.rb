module Creators::AwayStartsCreator

  def create_away_starting_lineup(starting_players, fixture)
    starting_players.map { |player| create_appearance(player['player']['id'], fixture) }
  end

  private

  def create_appearance(player_id, fixture)
    Appearance.new.create_appearance_for_player(player_id, fixture, fixture.away_team_season)
  end
end
