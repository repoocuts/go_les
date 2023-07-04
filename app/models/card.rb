class Card < ApplicationRecord
  belongs_to :appearance
  belongs_to :player_season
  belongs_to :team_season
  belongs_to :fixture

  scope :home_cards, ->(fixture) { where(is_home: true, fixture_id: fixture.id) }
  scope :away_cards, ->(fixture) { where(is_home: nil, fixture_id: fixture.id) }
  scope :home_yellow_cards, ->(fixture) { where(is_home: true, fixture_id: fixture.id, card_type: 'yellow') }
  scope :away_yellow_cards, ->(fixture) { where(is_home: nil, fixture_id: fixture.id, card_type: 'yellow') }
  scope :home_red_cards, ->(fixture) { where(is_home: true, fixture_id: fixture.id, card_type: 'red') }
  scope :away_red_cards, ->(fixture) { where(is_home: nil, fixture_id: fixture.id, card_type: 'red') }
  scope :yellow_cards, -> { where(card_type: 'yellow') }
  scope :red_cards, -> { where(card_type: 'red') }
  scope :group_by_player_season, -> { group(:player_season_id) }
  
  def card_receiver_name
    player_season.get_player_name
  end

  def card_team_name
    team_season.team_name
  end

end
