class Team < ApplicationRecord
  has_many :players
  belongs_to :league
  has_many :team_seasons

  def current_team_season
    team_seasons.find_by(current_season: true)
  end

  def next_match
    Fixture.where()
  end
end
