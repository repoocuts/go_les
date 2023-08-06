module HomeStartsCreator

  def create_home_starting_lineup(starting_players, fixture)
    starting_players.map { |player| create_appearance(player['player']['id'], fixture) }
  end

  private

  def create_appearance(player_id, fixture)
    Appearance.new.create_appearance_for_player(player_id, fixture, fixture.home_team_season, true)
  end
end
