# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_07_15_202612) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appearances", force: :cascade do |t|
    t.integer "minutes"
    t.string "appearance_type"
    t.boolean "is_home"
    t.bigint "player_season_id", null: false
    t.bigint "team_season_id", null: false
    t.bigint "fixture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "goals_count", default: 0, null: false
    t.integer "assists_count", default: 0, null: false
    t.index ["fixture_id"], name: "index_appearances_on_fixture_id"
    t.index ["player_season_id"], name: "index_appearances_on_player_season_id"
    t.index ["team_season_id"], name: "index_appearances_on_team_season_id"
  end

  create_table "assists", force: :cascade do |t|
    t.bigint "player_season_id", null: false
    t.bigint "goal_id", null: false
    t.bigint "team_season_id", null: false
    t.bigint "fixture_id", null: false
    t.bigint "appearance_id", null: false
    t.boolean "is_home"
    t.integer "minute"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appearance_id"], name: "index_assists_on_appearance_id"
    t.index ["fixture_id"], name: "index_assists_on_fixture_id"
    t.index ["goal_id"], name: "index_assists_on_goal_id"
    t.index ["player_season_id"], name: "index_assists_on_player_season_id"
    t.index ["team_season_id"], name: "index_assists_on_team_season_id"
  end

  create_table "attacking_stats", force: :cascade do |t|
    t.bigint "player_season_id", null: false
    t.integer "scored_total", default: 0
    t.integer "scored_home", default: 0
    t.integer "scored_away", default: 0
    t.integer "scored_first_half", default: 0
    t.integer "scored_second_half", default: 0
    t.integer "scored_home_first_half", default: 0
    t.integer "scored_away_first_half", default: 0
    t.integer "scored_home_second_half", default: 0
    t.integer "scored_away_second_half", default: 0
    t.integer "assists_total", default: 0
    t.integer "assists_home", default: 0
    t.integer "assists_away", default: 0
    t.integer "assists_first_half", default: 0
    t.integer "assists_second_half", default: 0
    t.integer "assists_home_first_half", default: 0
    t.integer "assists_away_first_half", default: 0
    t.integer "assists_home_second_half", default: 0
    t.integer "assists_away_second_half", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_season_id"], name: "index_attacking_stats_on_player_season_id"
  end

  create_table "cards", force: :cascade do |t|
    t.integer "minute"
    t.string "card_type"
    t.boolean "is_home"
    t.integer "first_card_id"
    t.bigint "appearance_id", null: false
    t.bigint "player_season_id", null: false
    t.bigint "team_season_id", null: false
    t.bigint "fixture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "referee_fixture_id"
    t.index ["appearance_id"], name: "index_cards_on_appearance_id"
    t.index ["card_type"], name: "index_cards_on_card_type"
    t.index ["fixture_id"], name: "index_cards_on_fixture_id"
    t.index ["player_season_id"], name: "index_cards_on_player_season_id"
    t.index ["team_season_id"], name: "index_cards_on_team_season_id"
  end

  create_table "corners", force: :cascade do |t|
    t.bigint "team_season_id", null: false
    t.bigint "fixture_id", null: false
    t.boolean "is_home"
    t.integer "minute"
    t.boolean "is_first_half"
    t.boolean "is_second_half"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixture_id"], name: "index_corners_on_fixture_id"
    t.index ["team_season_id"], name: "index_corners_on_team_season_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "api_football_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "flag"
    t.boolean "hidden"
    t.index ["slug"], name: "index_countries_on_slug", unique: true
  end

  create_table "dashboards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "defensive_stats", force: :cascade do |t|
    t.bigint "player_season_id", null: false
    t.integer "conceded_total", default: 0
    t.integer "conceded_home", default: 0
    t.integer "conceded_away", default: 0
    t.integer "conceded_first_half", default: 0
    t.integer "conceded_second_half", default: 0
    t.integer "conceded_home_first_half", default: 0
    t.integer "conceded_away_first_half", default: 0
    t.integer "conceded_home_second_half", default: 0
    t.integer "conceded_away_second_half", default: 0
    t.integer "clean_sheet_total", default: 0
    t.integer "clean_sheet_home", default: 0
    t.integer "clean_sheet_away", default: 0
    t.integer "clean_sheet_first_half", default: 0
    t.integer "clean_sheet_second_half", default: 0
    t.integer "clean_sheet_home_first_half", default: 0
    t.integer "clean_sheet_away_first_half", default: 0
    t.integer "clean_sheet_home_second_half", default: 0
    t.integer "clean_sheet_away_second_half", default: 0
    t.index ["player_season_id"], name: "index_defensive_stats_on_player_season_id"
  end

  create_table "discipline_stats", force: :cascade do |t|
    t.bigint "player_season_id", null: false
    t.integer "yellow_card_total", default: 0
    t.integer "yellow_card_home", default: 0
    t.integer "yellow_card_away", default: 0
    t.integer "yellow_card_first_half", default: 0
    t.integer "yellow_card_second_half", default: 0
    t.integer "yellow_card_home_first_half", default: 0
    t.integer "yellow_card_away_first_half", default: 0
    t.integer "yellow_card_home_second_half", default: 0
    t.integer "yellow_card_away_second_half", default: 0
    t.integer "red_card_total", default: 0
    t.integer "red_card_home", default: 0
    t.integer "red_card_away", default: 0
    t.integer "red_card_first_half", default: 0
    t.integer "red_card_second_half", default: 0
    t.integer "red_card_home_first_half", default: 0
    t.integer "red_card_away_first_half", default: 0
    t.integer "red_card_home_second_half", default: 0
    t.integer "red_card_away_second_half", default: 0
    t.index ["player_season_id"], name: "index_discipline_stats_on_player_season_id"
  end

  create_table "fixture_api_responses", force: :cascade do |t|
    t.jsonb "pre_fixture"
    t.jsonb "finished_fixture"
    t.bigint "fixture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixture_id"], name: "index_fixture_api_responses_on_fixture_id"
  end

  create_table "fixtures", force: :cascade do |t|
    t.integer "home_team_season_id"
    t.integer "away_team_season_id"
    t.integer "home_score"
    t.integer "away_score"
    t.datetime "kick_off"
    t.integer "game_week"
    t.integer "api_football_id"
    t.bigint "season_id", null: false
    t.bigint "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "season_game_week_id"
    t.integer "home_corners"
    t.integer "away_corners"
    t.index ["away_score"], name: "index_fixtures_on_away_score"
    t.index ["away_team_season_id"], name: "index_fixtures_on_away_team_season_id"
    t.index ["game_week"], name: "index_fixtures_on_game_week"
    t.index ["home_score"], name: "index_fixtures_on_home_score"
    t.index ["home_team_season_id"], name: "index_fixtures_on_home_team_season_id"
    t.index ["kick_off"], name: "index_fixtures_on_kick_off"
    t.index ["league_id"], name: "index_fixtures_on_league_id"
    t.index ["season_game_week_id"], name: "index_fixtures_on_season_game_week_id"
    t.index ["season_id"], name: "index_fixtures_on_season_id"
  end

  create_table "goals", force: :cascade do |t|
    t.integer "minute"
    t.string "goal_type"
    t.boolean "is_home"
    t.boolean "own_goal"
    t.bigint "appearance_id", null: false
    t.bigint "player_season_id", null: false
    t.bigint "team_season_id", null: false
    t.bigint "fixture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "referee_fixture_id"
    t.integer "assist_id"
    t.index ["appearance_id"], name: "index_goals_on_appearance_id"
    t.index ["assist_id"], name: "index_goals_on_assist_id"
    t.index ["fixture_id"], name: "index_goals_on_fixture_id"
    t.index ["goal_type"], name: "index_goals_on_goal_type"
    t.index ["player_season_id"], name: "index_goals_on_player_season_id"
    t.index ["team_season_id"], name: "index_goals_on_team_season_id"
  end

  create_table "goals_conceded_stats", force: :cascade do |t|
    t.bigint "team_season_id", null: false
    t.integer "total", default: 0
    t.integer "home", default: 0
    t.integer "away", default: 0
    t.integer "first_half", default: 0
    t.integer "second_half", default: 0
    t.integer "home_first_half", default: 0
    t.integer "away_first_half", default: 0
    t.integer "home_second_half", default: 0
    t.integer "away_second_half", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_season_id"], name: "index_goals_conceded_stats_on_team_season_id"
  end

  create_table "goals_scored_stats", force: :cascade do |t|
    t.bigint "team_season_id", null: false
    t.integer "total", default: 0
    t.integer "home", default: 0
    t.integer "away", default: 0
    t.integer "first_half", default: 0
    t.integer "second_half", default: 0
    t.integer "home_first_half", default: 0
    t.integer "away_first_half", default: 0
    t.integer "home_second_half", default: 0
    t.integer "away_second_half", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_season_id"], name: "index_goals_scored_stats_on_team_season_id"
  end

  create_table "head_to_heads", force: :cascade do |t|
    t.integer "bookings_received", default: 0
    t.integer "conceded_against_opponent", default: 0
    t.integer "conceded_away", default: 0
    t.integer "conceded_home", default: 0
    t.integer "current_season_fixture_ids", default: [], array: true
    t.integer "current_team_season_id"
    t.integer "fixture_ids", default: [], array: true
    t.integer "fixtures_played", default: 0
    t.integer "opponent_bookings", default: 0
    t.integer "opponent_id", default: 0
    t.integer "opponent_reds", default: 0
    t.integer "opponent_top_assist_player_season_id"
    t.integer "opponent_top_scorer_player_season_id"
    t.integer "reds_received", default: 0
    t.integer "scored_against_opponent", default: 0
    t.integer "scored_away", default: 0
    t.integer "scored_home", default: 0
    t.integer "top_assist_player_season_id"
    t.integer "top_scorer_player_season_id"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "last_match_id"
    t.index ["fixture_ids"], name: "index_head_to_heads_on_fixture_ids", using: :gin
    t.index ["team_id"], name: "index_head_to_heads_on_team_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.integer "api_football_id"
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "logo"
    t.boolean "hidden"
    t.index ["country_id"], name: "index_leagues_on_country_id"
    t.index ["slug"], name: "index_leagues_on_slug", unique: true
  end

  create_table "object_handling_failures", force: :cascade do |t|
    t.string "object_type"
    t.jsonb "api_response_element"
    t.jsonb "other_attributes"
    t.integer "related_country_id"
    t.integer "related_league_id"
    t.integer "related_season_id"
    t.integer "related_fixture_id"
    t.integer "related_team_id"
    t.integer "related_team_season_id"
    t.integer "related_player_id"
    t.integer "related_player_season_id"
    t.integer "related_appearance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_seasons", force: :cascade do |t|
    t.integer "api_football_id"
    t.bigint "team_season_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "current_season"
    t.integer "assists_count", default: 0, null: false
    t.integer "goals_count", default: 0, null: false
    t.integer "appearances_count", default: 0, null: false
    t.index ["appearances_count"], name: "index_player_seasons_on_appearances_count"
    t.index ["assists_count"], name: "index_player_seasons_on_assists_count"
    t.index ["goals_count"], name: "index_player_seasons_on_goals_count"
    t.index ["player_id"], name: "index_player_seasons_on_player_id"
    t.index ["team_season_id", "goals_count"], name: "index_player_seasons_on_team_season_id_and_goals_count"
    t.index ["team_season_id"], name: "index_player_seasons_on_team_season_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "full_name"
    t.string "short_name"
    t.integer "api_football_id"
    t.bigint "team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "position"
    t.string "slug"
    t.index ["full_name"], name: "index_players_on_full_name"
    t.index ["short_name"], name: "index_players_on_short_name"
    t.index ["slug"], name: "index_players_on_slug", unique: true
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "red_cards_stats", force: :cascade do |t|
    t.bigint "team_season_id", null: false
    t.integer "total"
    t.integer "home"
    t.integer "away"
    t.integer "first_half"
    t.integer "second_half"
    t.integer "home_first_half"
    t.integer "away_first_half"
    t.integer "home_second_half"
    t.integer "away_second_half"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_season_id"], name: "index_red_cards_stats_on_team_season_id"
  end

  create_table "referee_fixtures", force: :cascade do |t|
    t.bigint "fixture_id", null: false
    t.bigint "referee_id", null: false
    t.bigint "season_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixture_id"], name: "index_referee_fixtures_on_fixture_id"
    t.index ["referee_id"], name: "index_referee_fixtures_on_referee_id"
    t.index ["season_id"], name: "index_referee_fixtures_on_season_id"
  end

  create_table "referees", force: :cascade do |t|
    t.string "name"
    t.bigint "season_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_referees_on_season_id"
  end

  create_table "season_game_weeks", force: :cascade do |t|
    t.bigint "season_id"
    t.bigint "fixture_id"
    t.integer "game_week_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixture_id"], name: "index_season_game_weeks_on_fixture_id"
    t.index ["game_week_number"], name: "index_season_game_weeks_on_game_week_number"
    t.index ["season_id"], name: "index_season_game_weeks_on_season_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "api_football_id"
    t.boolean "current_season"
    t.integer "current_game_week"
    t.bigint "league_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "years"
    t.index ["league_id"], name: "index_seasons_on_league_id"
    t.index ["slug"], name: "index_seasons_on_slug", unique: true
  end

  create_table "team_seasons", force: :cascade do |t|
    t.integer "api_football_id"
    t.bigint "season_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "current_season"
    t.integer "points"
    t.integer "assists_count", default: 0, null: false
    t.integer "goals_count", default: 0, null: false
    t.integer "appearances_count", default: 0, null: false
    t.integer "yellow_cards_count", default: 0, null: false
    t.integer "red_cards_count", default: 0, null: false
    t.index ["appearances_count"], name: "index_team_seasons_on_appearances_count"
    t.index ["assists_count"], name: "index_team_seasons_on_assists_count"
    t.index ["goals_count"], name: "index_team_seasons_on_goals_count"
    t.index ["red_cards_count"], name: "index_team_seasons_on_red_cards_count"
    t.index ["season_id"], name: "index_team_seasons_on_season_id"
    t.index ["team_id"], name: "index_team_seasons_on_team_id"
    t.index ["yellow_cards_count"], name: "index_team_seasons_on_yellow_cards_count"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.string "acronym"
    t.integer "api_football_id"
    t.bigint "league_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["acronym"], name: "index_teams_on_acronym"
    t.index ["country_id"], name: "index_teams_on_country_id"
    t.index ["league_id"], name: "index_teams_on_league_id"
    t.index ["name"], name: "index_teams_on_name"
    t.index ["slug"], name: "index_teams_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  create_table "yellow_cards_stats", force: :cascade do |t|
    t.bigint "team_season_id", null: false
    t.integer "total"
    t.integer "home"
    t.integer "away"
    t.integer "first_half"
    t.integer "second_half"
    t.integer "home_first_half"
    t.integer "away_first_half"
    t.integer "home_second_half"
    t.integer "away_second_half"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_season_id"], name: "index_yellow_cards_stats_on_team_season_id"
  end

  add_foreign_key "appearances", "fixtures", on_delete: :cascade
  add_foreign_key "appearances", "player_seasons", on_delete: :cascade
  add_foreign_key "appearances", "team_seasons", on_delete: :cascade
  add_foreign_key "assists", "appearances", on_delete: :cascade
  add_foreign_key "assists", "fixtures", on_delete: :cascade
  add_foreign_key "assists", "goals", on_delete: :cascade
  add_foreign_key "assists", "player_seasons", on_delete: :cascade
  add_foreign_key "assists", "team_seasons", on_delete: :cascade
  add_foreign_key "attacking_stats", "player_seasons"
  add_foreign_key "cards", "appearances", on_delete: :cascade
  add_foreign_key "cards", "fixtures", on_delete: :cascade
  add_foreign_key "cards", "player_seasons", on_delete: :cascade
  add_foreign_key "cards", "team_seasons", on_delete: :cascade
  add_foreign_key "corners", "fixtures"
  add_foreign_key "corners", "team_seasons"
  add_foreign_key "defensive_stats", "player_seasons"
  add_foreign_key "discipline_stats", "player_seasons"
  add_foreign_key "fixture_api_responses", "fixtures", on_delete: :cascade
  add_foreign_key "fixtures", "leagues", on_delete: :cascade
  add_foreign_key "fixtures", "season_game_weeks"
  add_foreign_key "fixtures", "seasons"
  add_foreign_key "goals", "appearances", on_delete: :cascade
  add_foreign_key "goals", "fixtures", on_delete: :cascade
  add_foreign_key "goals", "player_seasons", on_delete: :cascade
  add_foreign_key "goals", "team_seasons", on_delete: :cascade
  add_foreign_key "goals_conceded_stats", "team_seasons", on_delete: :cascade
  add_foreign_key "goals_scored_stats", "team_seasons", on_delete: :cascade
  add_foreign_key "head_to_heads", "teams", on_delete: :cascade
  add_foreign_key "leagues", "countries", on_delete: :cascade
  add_foreign_key "player_seasons", "players", on_delete: :cascade
  add_foreign_key "player_seasons", "team_seasons", on_delete: :cascade
  add_foreign_key "players", "teams", on_delete: :nullify
  add_foreign_key "red_cards_stats", "team_seasons", on_delete: :cascade
  add_foreign_key "referee_fixtures", "fixtures"
  add_foreign_key "referee_fixtures", "referees", on_delete: :cascade
  add_foreign_key "referee_fixtures", "seasons", on_delete: :cascade
  add_foreign_key "referees", "seasons", on_delete: :cascade
  add_foreign_key "seasons", "leagues", on_delete: :cascade
  add_foreign_key "team_seasons", "seasons", on_delete: :cascade
  add_foreign_key "team_seasons", "teams", on_delete: :cascade
  add_foreign_key "teams", "countries", on_delete: :cascade
  add_foreign_key "teams", "leagues", on_delete: :cascade
  add_foreign_key "yellow_cards_stats", "team_seasons", on_delete: :cascade
end
