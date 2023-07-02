class Goal < ApplicationRecord
  belongs_to :player_season
  belongs_to :team_season
  belongs_to :fixture
end
