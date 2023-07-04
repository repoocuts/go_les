class Goal < ApplicationRecord
  belongs_to :appearance
  belongs_to :player_season
  belongs_to :team_season
  belongs_to :fixture
  
  has_one :assist

  scope :home_goals, ->(fixture) { where(is_home: true, fixture_id: fixture.id) }
  scope :away_goals, ->(fixture) { where(is_home: nil, fixture_id: fixture.id) }
  scope :group_by_player_season, -> { group(:player_season_id) }
  scope :first_half_goals, -> { where('minute < ?', 46) }
  scope :second_half_goals, -> { where('minute > ?', 45) }

  def goal_scorer_name
    player_season.get_player_name
  end

  def goal_team_name
    team_season.team_name
  end
end
