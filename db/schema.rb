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

ActiveRecord::Schema[7.0].define(version: 2023_12_28_210109) do
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
    t.index ["appearance_id"], name: "index_cards_on_appearance_id"
    t.index ["fixture_id"], name: "index_cards_on_fixture_id"
    t.index ["player_season_id"], name: "index_cards_on_player_season_id"
    t.index ["team_season_id"], name: "index_cards_on_team_season_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "api_football_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dashboards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["away_team_season_id"], name: "index_fixtures_on_away_team_season_id"
    t.index ["home_team_season_id"], name: "index_fixtures_on_home_team_season_id"
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
    t.index ["appearance_id"], name: "index_goals_on_appearance_id"
    t.index ["fixture_id"], name: "index_goals_on_fixture_id"
    t.index ["player_season_id"], name: "index_goals_on_player_season_id"
    t.index ["team_season_id"], name: "index_goals_on_team_season_id"
  end

  create_table "goals_conceded_stats", force: :cascade do |t|
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
    t.index ["team_season_id"], name: "index_goals_conceded_stats_on_team_season_id"
  end

  create_table "goals_scored_stats", force: :cascade do |t|
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
    t.index ["team_season_id"], name: "index_goals_scored_stats_on_team_season_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "name"
    t.integer "api_football_id"
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_leagues_on_country_id"
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
    t.index ["player_id"], name: "index_player_seasons_on_player_id"
    t.index ["team_season_id"], name: "index_player_seasons_on_team_season_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "full_name"
    t.string "short_name"
    t.integer "api_football_id"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
    t.index ["team_id"], name: "index_players_on_team_id"
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
    t.index ["league_id"], name: "index_seasons_on_league_id"
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
    t.index ["season_id"], name: "index_team_seasons_on_season_id"
    t.index ["team_id"], name: "index_team_seasons_on_team_id"
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
    t.index ["country_id"], name: "index_teams_on_country_id"
    t.index ["league_id"], name: "index_teams_on_league_id"
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

  add_foreign_key "appearances", "fixtures"
  add_foreign_key "appearances", "player_seasons"
  add_foreign_key "appearances", "team_seasons"
  add_foreign_key "assists", "appearances"
  add_foreign_key "assists", "fixtures"
  add_foreign_key "assists", "goals"
  add_foreign_key "assists", "player_seasons"
  add_foreign_key "assists", "team_seasons"
  add_foreign_key "cards", "appearances"
  add_foreign_key "cards", "fixtures"
  add_foreign_key "cards", "player_seasons"
  add_foreign_key "cards", "team_seasons"
  add_foreign_key "fixtures", "leagues"
  add_foreign_key "fixtures", "season_game_weeks"
  add_foreign_key "fixtures", "seasons"
  add_foreign_key "goals", "appearances"
  add_foreign_key "goals", "fixtures"
  add_foreign_key "goals", "player_seasons"
  add_foreign_key "goals", "team_seasons"
  add_foreign_key "goals_conceded_stats", "team_seasons"
  add_foreign_key "goals_scored_stats", "team_seasons"
  add_foreign_key "leagues", "countries"
  add_foreign_key "player_seasons", "players"
  add_foreign_key "player_seasons", "team_seasons"
  add_foreign_key "players", "teams"
  add_foreign_key "seasons", "leagues"
  add_foreign_key "team_seasons", "seasons"
  add_foreign_key "team_seasons", "teams"
  add_foreign_key "teams", "countries"
  add_foreign_key "teams", "leagues"
end
