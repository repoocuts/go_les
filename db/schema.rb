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

ActiveRecord::Schema[7.0].define(version: 2023_07_30_164520) do
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
    t.index ["fixture_id"], name: "index_appearances_on_fixture_id"
    t.index ["player_season_id"], name: "index_appearances_on_player_season_id"
    t.index ["team_season_id"], name: "index_appearances_on_team_season_id"
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
    t.index ["league_id"], name: "index_fixtures_on_league_id"
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
    t.index ["player_id"], name: "index_player_seasons_on_player_id"
    t.index ["team_season_id"], name: "index_player_seasons_on_team_season_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "full_name"
    t.string "short_name"
    t.string "position"
    t.integer "api_football_id"
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
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

  add_foreign_key "appearances", "fixtures"
  add_foreign_key "appearances", "player_seasons"
  add_foreign_key "appearances", "team_seasons"
  add_foreign_key "cards", "appearances"
  add_foreign_key "cards", "fixtures"
  add_foreign_key "cards", "player_seasons"
  add_foreign_key "cards", "team_seasons"
  add_foreign_key "fixtures", "leagues"
  add_foreign_key "fixtures", "seasons"
  add_foreign_key "goals", "appearances"
  add_foreign_key "goals", "fixtures"
  add_foreign_key "goals", "player_seasons"
  add_foreign_key "goals", "team_seasons"
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
