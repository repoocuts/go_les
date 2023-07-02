class Card < ApplicationRecord
  belongs_to :appearance
  belongs_to :player_season
  belongs_to :team_season
  belongs_to :fixture
end
