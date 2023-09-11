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

ActiveRecord::Schema[7.0].define(version: 2023_09_04_071951) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.integer "following_user_id"
    t.integer "followed_user_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "formations", force: :cascade do |t|
    t.string "formation_name"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_weeks", force: :cascade do |t|
    t.integer "league_id"
    t.integer "week_number"
    t.integer "season"
    t.date "start_date"
    t.date "end_date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_game_weeks_on_league_id"
    t.index ["user_id"], name: "index_game_weeks_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "league_name"
    t.string "country"
    t.integer "tier_level"
    t.string "description"
    t.string "division_photo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leagues_on_user_id"
  end

  create_table "lineup_players", force: :cascade do |t|
    t.integer "match_lineup_id"
    t.integer "lineup_position_id"
    t.integer "player_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_lineup_id"], name: "index_lineup_players_on_match_lineup_id"
  end

  create_table "lineup_positions", force: :cascade do |t|
    t.integer "formation_id"
    t.string "position_name"
    t.integer "position_order"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formation_id"], name: "index_lineup_positions_on_formation_id"
    t.index ["user_id"], name: "index_lineup_positions_on_user_id"
  end

  create_table "lineup_substitute_options", force: :cascade do |t|
    t.integer "match_lineup_id"
    t.integer "team_id"
    t.integer "substitute_player_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_lineup_id"], name: "index_lineup_substitute_options_on_match_lineup_id"
    t.index ["substitute_player_id"], name: "index_lineup_substitute_options_on_substitute_player_id"
    t.index ["team_id"], name: "index_lineup_substitute_options_on_team_id"
    t.index ["user_id"], name: "index_lineup_substitute_options_on_user_id"
  end

  create_table "match_events", force: :cascade do |t|
    t.integer "match_id"
    t.string "event_type"
    t.text "event_description"
    t.integer "event_minute"
    t.integer "player_id"
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_events_on_match_id"
    t.index ["player_id"], name: "index_match_events_on_player_id"
    t.index ["team_id"], name: "index_match_events_on_team_id"
    t.index ["user_id"], name: "index_match_events_on_user_id"
  end

  create_table "match_goals", force: :cascade do |t|
    t.integer "match_id"
    t.integer "scorer_player_id"
    t.integer "assister_player_id"
    t.integer "team_for_id"
    t.integer "team_against_id"
    t.boolean "penaly_goal"
    t.boolean "own_goal"
    t.string "goal_type"
    t.string "goal_desc"
    t.integer "minute_scored"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_goals_on_match_id"
    t.index ["user_id"], name: "index_match_goals_on_user_id"
  end

  create_table "match_lineups", force: :cascade do |t|
    t.integer "match_id"
    t.integer "formation_id"
    t.string "lineup_name"
    t.string "comments"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formation_id"], name: "index_match_lineups_on_formation_id"
    t.index ["match_id"], name: "index_match_lineups_on_match_id"
    t.index ["user_id"], name: "index_match_lineups_on_user_id"
  end

  create_table "match_official_for_matches", force: :cascade do |t|
    t.integer "match_official_id"
    t.integer "match_id"
    t.string "role"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_official_id"], name: "index_match_official_for_matches_on_match_official_id"
    t.index ["user_id"], name: "index_match_official_for_matches_on_user_id"
  end

  create_table "match_officials", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nationality"
    t.date "date_of_birth"
    t.string "official_photo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_match_officials_on_user_id"
  end

  create_table "match_shots", force: :cascade do |t|
    t.integer "match_id"
    t.integer "player_id"
    t.integer "team_id"
    t.integer "minute_shot"
    t.boolean "is_on_target"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "match_substitutions", force: :cascade do |t|
    t.integer "match_id"
    t.integer "substitution_player_in_id"
    t.integer "substitution_player_out_id"
    t.integer "minute_substituted"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_substitutions_on_match_id"
    t.index ["user_id"], name: "index_match_substitutions_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.date "date"
    t.string "time"
    t.integer "stadium_id"
    t.integer "referee_id"
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "home_team_score"
    t.integer "away_team_score"
    t.integer "league_id"
    t.integer "game_week_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_injuries", force: :cascade do |t|
    t.integer "player_id"
    t.string "injury_type"
    t.text "description"
    t.date "start_date"
    t.date "end_date"
    t.string "recovery_status"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_injuries_on_player_id"
    t.index ["user_id"], name: "index_player_injuries_on_user_id"
  end

  create_table "player_stats", force: :cascade do |t|
    t.integer "player_id"
    t.integer "match_id"
    t.integer "goals_scored"
    t.integer "assists"
    t.integer "yellow_cards"
    t.integer "red_cards"
    t.integer "offsides"
    t.integer "passes_attempted"
    t.integer "passes_completed"
    t.integer "dribbles_attempted"
    t.integer "dribbles_completed"
    t.integer "shots_conceded"
    t.integer "shots_on_target"
    t.integer "shots_off_target"
    t.integer "saves"
    t.integer "lost_possession"
    t.integer "gained_possession"
    t.integer "touches"
    t.integer "key_passes"
    t.integer "big_chance_created"
    t.integer "big_chance_missed"
    t.integer "clean_sheet"
    t.integer "aerial_duels_won"
    t.integer "aerial_duels_lost"
    t.integer "ground_duels_won"
    t.integer "ground_duels_lost"
    t.integer "clearances"
    t.integer "errors_leading_to_goal"
    t.integer "errors_leading_to_shot"
    t.integer "penalties_conceded"
    t.integer "penalties_gained"
    t.integer "fouls_committed"
    t.integer "fouls_conceded"
    t.integer "minutes_played"
    t.string "position"
    t.string "substitution_type"
    t.float "player_rating"
    t.integer "penalties_saved"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_player_stats_on_user_id"
  end

  create_table "player_team_histories", force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.integer "start_year"
    t.integer "end_year"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_team_histories_on_player_id"
    t.index ["team_id"], name: "index_player_team_histories_on_team_id"
    t.index ["user_id"], name: "index_player_team_histories_on_user_id"
  end

  create_table "player_transfers", force: :cascade do |t|
    t.integer "player_id"
    t.integer "from_team_id"
    t.integer "to_team_id"
    t.date "transfer_date"
    t.float "transfer_fee"
    t.string "transfer_type"
    t.string "transfer_window"
    t.string "transfer_status"
    t.string "transfer_contract"
    t.string "transfer_contract_duration"
    t.string "transfer_contract_salary"
    t.string "transfer_contract_bonus"
    t.string "transfer_contract_clause"
    t.string "transfer_contract_release_clause"
    t.string "transfer_contract_agent_fee"
    t.string "transfer_contract_agent"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_transfers_on_player_id"
    t.index ["user_id"], name: "index_player_transfers_on_user_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "player_name"
    t.string "nationality"
    t.date "date_of_birth"
    t.float "player_height"
    t.float "player_weight"
    t.integer "player_shirt_number"
    t.string "player_photo"
    t.integer "current_team_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "photo"
    t.integer "user_id"
    t.string "status"
    t.integer "team_id"
    t.integer "player_id"
    t.integer "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "referees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "nationality"
    t.date "date_of_birth"
    t.integer "experience_years"
    t.string "referee_photo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_referees_on_user_id"
  end

  create_table "stadiums", force: :cascade do |t|
    t.string "stadium_name"
    t.string "city"
    t.string "country"
    t.integer "capacity"
    t.integer "year_opened"
    t.string "stadium_photo"
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_stadiums_on_team_id"
    t.index ["user_id"], name: "index_stadiums_on_user_id"
  end

  create_table "team_shots", force: :cascade do |t|
    t.integer "match_id"
    t.integer "team_id"
    t.integer "total_shots"
    t.integer "shots_on_target"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_team_shots_on_match_id"
    t.index ["team_id"], name: "index_team_shots_on_team_id"
    t.index ["user_id"], name: "index_team_shots_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.string "country"
    t.integer "founded_year"
    t.bigint "league_id", null: false
    t.string "description"
    t.string "coach_name"
    t.string "website"
    t.string "trophy_photo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_teams_on_league_id"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "trophies", force: :cascade do |t|
    t.string "trophy_name"
    t.integer "year"
    t.string "trophy_photo"
    t.integer "team_id"
    t.integer "league_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_trophies_on_league_id"
    t.index ["team_id"], name: "index_trophies_on_team_id"
    t.index ["user_id"], name: "index_trophies_on_user_id"
  end

  create_table "trophy_players", force: :cascade do |t|
    t.bigint "trophy_id", null: false
    t.bigint "player_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_trophy_players_on_player_id"
    t.index ["trophy_id"], name: "index_trophy_players_on_trophy_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "email", null: false
    t.string "role", default: "client"
    t.string "user_photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "followed_user_id"
  add_foreign_key "follows", "users", column: "following_user_id"
  add_foreign_key "game_weeks", "leagues"
  add_foreign_key "game_weeks", "users"
  add_foreign_key "leagues", "users"
  add_foreign_key "lineup_players", "lineup_positions"
  add_foreign_key "lineup_players", "match_lineups"
  add_foreign_key "lineup_players", "players"
  add_foreign_key "lineup_players", "users"
  add_foreign_key "lineup_positions", "formations"
  add_foreign_key "lineup_positions", "users"
  add_foreign_key "lineup_substitute_options", "match_lineups"
  add_foreign_key "lineup_substitute_options", "players", column: "substitute_player_id"
  add_foreign_key "lineup_substitute_options", "teams"
  add_foreign_key "lineup_substitute_options", "users"
  add_foreign_key "match_events", "matches"
  add_foreign_key "match_events", "players"
  add_foreign_key "match_events", "teams"
  add_foreign_key "match_events", "users"
  add_foreign_key "match_goals", "matches"
  add_foreign_key "match_goals", "players", column: "assister_player_id"
  add_foreign_key "match_goals", "players", column: "scorer_player_id"
  add_foreign_key "match_goals", "teams", column: "team_for_id"
  add_foreign_key "match_goals", "users"
  add_foreign_key "match_lineups", "formations"
  add_foreign_key "match_lineups", "matches"
  add_foreign_key "match_lineups", "users"
  add_foreign_key "match_official_for_matches", "match_officials"
  add_foreign_key "match_official_for_matches", "matches"
  add_foreign_key "match_official_for_matches", "users"
  add_foreign_key "match_officials", "users"
  add_foreign_key "match_substitutions", "matches"
  add_foreign_key "match_substitutions", "players", column: "substitution_player_in_id"
  add_foreign_key "match_substitutions", "players", column: "substitution_player_out_id"
  add_foreign_key "match_substitutions", "users"
  add_foreign_key "player_injuries", "players"
  add_foreign_key "player_injuries", "users"
  add_foreign_key "player_stats", "matches"
  add_foreign_key "player_stats", "players"
  add_foreign_key "player_stats", "users"
  add_foreign_key "player_team_histories", "players"
  add_foreign_key "player_team_histories", "teams"
  add_foreign_key "player_team_histories", "users"
  add_foreign_key "player_transfers", "players"
  add_foreign_key "player_transfers", "teams", column: "from_team_id"
  add_foreign_key "player_transfers", "teams", column: "to_team_id"
  add_foreign_key "player_transfers", "users"
  add_foreign_key "players", "teams", column: "current_team_id"
  add_foreign_key "players", "users"
  add_foreign_key "posts", "leagues"
  add_foreign_key "posts", "players"
  add_foreign_key "posts", "teams"
  add_foreign_key "posts", "users"
  add_foreign_key "referees", "users"
  add_foreign_key "stadiums", "teams"
  add_foreign_key "stadiums", "users"
  add_foreign_key "team_shots", "matches"
  add_foreign_key "team_shots", "teams"
  add_foreign_key "team_shots", "users"
  add_foreign_key "teams", "leagues"
  add_foreign_key "teams", "users"
  add_foreign_key "trophies", "leagues"
  add_foreign_key "trophies", "teams"
  add_foreign_key "trophies", "users"
  add_foreign_key "trophy_players", "players"
  add_foreign_key "trophy_players", "trophies"
end
