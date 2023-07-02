json.extract! card, :id, :minute, :card_type, :is_home, :first_card_id, :appearance_id, :player_season_id, :team_season_id, :fixture_id, :created_at, :updated_at
json.url card_url(card, format: :json)
