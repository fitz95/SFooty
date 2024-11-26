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

ActiveRecord::Schema[7.0].define(version: 2024_11_26_101022) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "competitions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.string "location"
    t.text "description"
    t.index ["user_id"], name: "index_competitions_on_user_id"
  end

  create_table "error_leading_to_goals", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "team_id", null: false
    t.bigint "player_id", null: false
    t.bigint "user_id", null: false
    t.bigint "match_goal_id", null: false
    t.string "error_type"
    t.integer "minute"
    t.integer "additional_time"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_goal_id"], name: "index_error_leading_to_goals_on_match_goal_id"
    t.index ["match_id"], name: "index_error_leading_to_goals_on_match_id"
    t.index ["player_id"], name: "index_error_leading_to_goals_on_player_id"
    t.index ["team_id"], name: "index_error_leading_to_goals_on_team_id"
    t.index ["user_id"], name: "index_error_leading_to_goals_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "following_user_id"
    t.integer "followed_user_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "formation_positions", force: :cascade do |t|
    t.bigint "formation_id", null: false
    t.string "position_name"
    t.integer "position_order"
    t.integer "position_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["formation_id"], name: "index_formation_positions_on_formation_id"
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
    t.bigint "season_id", null: false
    t.text "description"
    t.boolean "completed", default: false
    t.index ["league_id"], name: "index_game_weeks_on_league_id"
    t.index ["season_id"], name: "index_game_weeks_on_season_id"
    t.index ["user_id"], name: "index_game_weeks_on_user_id"
  end

  create_table "league_groups", force: :cascade do |t|
    t.bigint "league_id", null: false
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_league_groups_on_league_id"
    t.index ["user_id"], name: "index_league_groups_on_user_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.string "league_name"
    t.string "country"
    t.integer "tier_level"
    t.string "description"
    t.string "league_photo"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_leagues_on_user_id"
  end

  create_table "lineup_players", force: :cascade do |t|
    t.integer "match_lineup_id"
    t.integer "player_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "formation_position_id", null: false
    t.string "position"
    t.boolean "is_captain", default: false
    t.boolean "is_substitute", default: false
    t.index ["formation_position_id"], name: "index_lineup_players_on_formation_position_id"
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

  create_table "managers", force: :cascade do |t|
    t.string "name"
    t.date "date_of_birth"
    t.string "nationality"
    t.integer "experience_level"
    t.date "hired_on"
    t.date "contract_end_date"
    t.decimal "salary"
    t.text "achievements"
    t.string "manager_type"
    t.string "previous_teams"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_managers_on_user_id"
  end

  create_table "match_blocks", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.bigint "opponent_id"
    t.boolean "is_successful"
    t.string "block_type"
    t.integer "minute"
    t.decimal "x"
    t.decimal "y"
    t.string "block_outcome"
    t.integer "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_blocks_on_match_id"
    t.index ["opponent_id"], name: "index_match_blocks_on_opponent_id"
    t.index ["player_id"], name: "index_match_blocks_on_player_id"
    t.index ["team_id"], name: "index_match_blocks_on_team_id"
    t.index ["user_id"], name: "index_match_blocks_on_user_id"
  end

  create_table "match_clearances", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.string "clearance_type"
    t.string "clearance_outcome"
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.integer "minute"
    t.boolean "successful"
    t.boolean "under_pressure", default: true
    t.boolean "resulted_in_corner", default: false
    t.boolean "resulted_in_throw_in", default: false
    t.boolean "resulted_in_goal", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_clearances_on_match_id"
    t.index ["player_id"], name: "index_match_clearances_on_player_id"
    t.index ["team_id"], name: "index_match_clearances_on_team_id"
    t.index ["user_id"], name: "index_match_clearances_on_user_id"
  end

  create_table "match_corners", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "team_id", null: false
    t.bigint "corner_taker_id"
    t.bigint "user_id", null: false
    t.integer "minute"
    t.string "outcome"
    t.string "side"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corner_taker_id"], name: "index_match_corners_on_corner_taker_id"
    t.index ["match_id"], name: "index_match_corners_on_match_id"
    t.index ["team_id"], name: "index_match_corners_on_team_id"
    t.index ["user_id"], name: "index_match_corners_on_user_id"
  end

  create_table "match_dribbles", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.bigint "opponent_id"
    t.integer "minute"
    t.boolean "is_successful"
    t.string "dribble_type"
    t.string "outcome"
    t.decimal "x"
    t.decimal "y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_dribbles_on_match_id"
    t.index ["opponent_id"], name: "index_match_dribbles_on_opponent_id"
    t.index ["player_id"], name: "index_match_dribbles_on_player_id"
    t.index ["team_id"], name: "index_match_dribbles_on_team_id"
    t.index ["user_id"], name: "index_match_dribbles_on_user_id"
  end

  create_table "match_duels", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.integer "opponent_player_id"
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.integer "minute"
    t.string "duel_type"
    t.boolean "aerial"
    t.boolean "ground"
    t.boolean "last_man"
    t.string "outcome"
    t.boolean "successful"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_duels_on_match_id"
    t.index ["opponent_player_id"], name: "index_match_duels_on_opponent_player_id"
    t.index ["player_id"], name: "index_match_duels_on_player_id"
    t.index ["team_id"], name: "index_match_duels_on_team_id"
    t.index ["user_id"], name: "index_match_duels_on_user_id"
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

  create_table "match_fouls", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "team_id", null: false
    t.bigint "player_id", null: false
    t.bigint "user_id", null: false
    t.integer "fouled_player_id"
    t.integer "fouled_official_id"
    t.string "foul_type"
    t.string "severity"
    t.string "card_issued"
    t.integer "tackle_id"
    t.integer "minute"
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.integer "opposing_team"
    t.boolean "penalty_awarded"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fouled_official_id"], name: "index_match_fouls_on_fouled_official_id"
    t.index ["fouled_player_id"], name: "index_match_fouls_on_fouled_player_id"
    t.index ["match_id"], name: "index_match_fouls_on_match_id"
    t.index ["player_id"], name: "index_match_fouls_on_player_id"
    t.index ["team_id"], name: "index_match_fouls_on_team_id"
    t.index ["user_id"], name: "index_match_fouls_on_user_id"
  end

  create_table "match_goals", force: :cascade do |t|
    t.integer "match_id"
    t.integer "scorer_id"
    t.integer "assister_id"
    t.boolean "is_penalty", default: false
    t.boolean "is_own_goal", default: false
    t.string "goal_type"
    t.string "goal_desc"
    t.integer "minute"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "match_shot_id"
    t.bigint "team_id"
    t.decimal "x", precision: 5, scale: 2
    t.decimal "y", precision: 5, scale: 2
    t.decimal "expected_goal_value", precision: 4, scale: 3
    t.index ["assister_id"], name: "index_match_goals_on_assister_id"
    t.index ["match_id"], name: "index_match_goals_on_match_id"
    t.index ["match_shot_id"], name: "index_match_goals_on_match_shot_id"
    t.index ["scorer_id"], name: "index_match_goals_on_scorer_id"
    t.index ["team_id"], name: "index_match_goals_on_team_id"
    t.index ["user_id"], name: "index_match_goals_on_user_id"
  end

  create_table "match_interceptions", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.bigint "match_pass_id"
    t.string "interception_type"
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.string "interception_outcome"
    t.integer "minute"
    t.boolean "successful"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_interceptions_on_match_id"
    t.index ["match_pass_id"], name: "index_match_interceptions_on_match_pass_id"
    t.index ["player_id"], name: "index_match_interceptions_on_player_id"
    t.index ["team_id"], name: "index_match_interceptions_on_team_id"
    t.index ["user_id"], name: "index_match_interceptions_on_user_id"
  end

  create_table "match_lineups", force: :cascade do |t|
    t.integer "match_id"
    t.integer "formation_id"
    t.string "lineup_name"
    t.string "comments"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id", null: false
    t.string "expected_match_lineup", default: [], array: true
    t.index ["formation_id"], name: "index_match_lineups_on_formation_id"
    t.index ["match_id", "team_id", "formation_id"], name: "index_match_lineups_on_match_team_formation", unique: true
    t.index ["match_id"], name: "index_match_lineups_on_match_id"
    t.index ["team_id"], name: "index_match_lineups_on_team_id"
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

  create_table "match_offsides", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.integer "minute"
    t.integer "last_man"
    t.boolean "resulted_in_goal", default: false
    t.string "opposing_team"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_man"], name: "index_match_offsides_on_last_man"
    t.index ["match_id"], name: "index_match_offsides_on_match_id"
    t.index ["player_id"], name: "index_match_offsides_on_player_id"
    t.index ["team_id"], name: "index_match_offsides_on_team_id"
    t.index ["user_id"], name: "index_match_offsides_on_user_id"
  end

  create_table "match_passes", force: :cascade do |t|
    t.integer "match_id", null: false
    t.integer "player_id", null: false
    t.integer "team_id", null: false
    t.integer "minute", null: false
    t.boolean "is_successful", default: false, null: false
    t.boolean "is_key_pass", default: false
    t.boolean "is_cross", default: false
    t.boolean "is_assist", default: false
    t.string "pass_type", default: "short", null: false
    t.string "pass_outcome", default: "incomplete", null: false
    t.decimal "pass_start_x", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "pass_start_y", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "pass_end_x", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "pass_end_y", precision: 5, scale: 2, default: "0.0", null: false
    t.decimal "pass_distance", precision: 5, scale: 2, default: "0.0", null: false
    t.string "pass_direction", default: "forward", null: false
    t.decimal "expected_assist_value", precision: 4, scale: 3, default: "0.0"
    t.integer "assister"
    t.integer "receiver"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assister"], name: "index_match_passes_on_assister"
    t.index ["match_id"], name: "index_match_passes_on_match_id"
    t.index ["player_id"], name: "index_match_passes_on_player_id"
    t.index ["receiver"], name: "index_match_passes_on_receiver"
    t.index ["team_id"], name: "index_match_passes_on_team_id"
    t.index ["user_id"], name: "index_match_passes_on_user_id"
  end

  create_table "match_shots", force: :cascade do |t|
    t.integer "match_id"
    t.integer "player_id"
    t.integer "team_id"
    t.integer "minute"
    t.boolean "is_on_target"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assist_player_id"
    t.string "shot_type", default: "unknown", null: false
    t.string "shot_outcome", default: "off target", null: false
    t.boolean "is_goal", default: false
    t.decimal "x", precision: 5, scale: 2, default: "0.0"
    t.decimal "y", precision: 5, scale: 2, default: "0.0"
    t.decimal "expected_goal_value", precision: 4, scale: 3, default: "0.0"
    t.bigint "user_id", null: false
    t.index ["assist_player_id"], name: "index_match_shots_on_assist_player_id"
    t.index ["user_id"], name: "index_match_shots_on_user_id"
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

  create_table "match_tackles", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.string "tackle_type"
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.integer "minute"
    t.boolean "successful"
    t.boolean "last_man"
    t.boolean "resulted_in_foul"
    t.string "resulted_in_card"
    t.string "tackle_outcome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_tackles_on_match_id"
    t.index ["player_id"], name: "index_match_tackles_on_player_id"
    t.index ["team_id"], name: "index_match_tackles_on_team_id"
    t.index ["user_id"], name: "index_match_tackles_on_user_id"
  end

  create_table "match_touches", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.string "touch_type"
    t.string "touch_direction"
    t.boolean "successful", default: false
    t.integer "x_coordinate"
    t.integer "y_coordinate"
    t.integer "minute"
    t.boolean "in_box", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_touches_on_match_id"
    t.index ["player_id"], name: "index_match_touches_on_player_id"
    t.index ["team_id"], name: "index_match_touches_on_team_id"
    t.index ["user_id"], name: "index_match_touches_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.date "date"
    t.string "time"
    t.integer "stadium_id"
    t.integer "referee_id"
    t.integer "home_team_id"
    t.integer "away_team_id"
    t.integer "league_id"
    t.integer "game_week_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "competition_id"
    t.index ["competition_id"], name: "index_matches_on_competition_id"
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
    t.bigint "league_id"
    t.index ["league_id"], name: "index_players_on_league_id"
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
    t.string "additional_images", default: [], array: true
    t.string "video"
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

  create_table "revoked_tokens", force: :cascade do |t|
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_revoked_tokens_on_token"
  end

  create_table "season_managers", force: :cascade do |t|
    t.string "role"
    t.decimal "performance_rating"
    t.date "season_start_date"
    t.date "season_end_date"
    t.integer "goals"
    t.decimal "bonuses"
    t.text "contract_terms"
    t.string "status"
    t.text "team_performance_notes"
    t.string "training_style"
    t.string "most_used_formation"
    t.string "most_improved_player"
    t.boolean "relegated"
    t.boolean "promoted"
    t.bigint "season_id", null: false
    t.bigint "manager_id", null: false
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_season_managers_on_manager_id"
    t.index ["season_id"], name: "index_season_managers_on_season_id"
    t.index ["team_id"], name: "index_season_managers_on_team_id"
    t.index ["user_id"], name: "index_season_managers_on_user_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.integer "number_of_teams"
    t.string "season_type"
    t.string "description"
    t.integer "total_matches"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_seasons_on_user_id"
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

  create_table "substitutions", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "player_in_id", null: false
    t.bigint "player_out_id", null: false
    t.integer "minute_in", null: false
    t.integer "minute_out", default: 90
    t.bigint "team_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_substitutions_on_match_id"
    t.index ["player_in_id"], name: "index_substitutions_on_player_in_id"
    t.index ["player_out_id"], name: "index_substitutions_on_player_out_id"
    t.index ["team_id"], name: "index_substitutions_on_team_id"
    t.index ["user_id"], name: "index_substitutions_on_user_id"
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

  create_table "team_stats", force: :cascade do |t|
    t.integer "team_id"
    t.integer "league_id"
    t.integer "matches_played"
    t.integer "matches_won"
    t.integer "matches_drawn"
    t.integer "matches_lost"
    t.integer "goals_scored"
    t.integer "goals_conceded"
    t.integer "clean_sheets"
    t.integer "yellow_cards"
    t.integer "red_cards"
    t.integer "shots_on_target"
    t.integer "shots_off_target"
    t.integer "corners"
    t.integer "fouls_committed"
    t.integer "fouls_conceded"
    t.integer "possessions"
    t.integer "passes_completed"
    t.integer "pass_accuracy"
    t.integer "aerial_duels_won"
    t.integer "aerial_duels_lost"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_team_stats_on_league_id"
    t.index ["team_id"], name: "index_team_stats_on_team_id"
    t.index ["user_id"], name: "index_team_stats_on_user_id"
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
    t.bigint "league_group_id", null: false
    t.index ["league_group_id"], name: "index_teams_on_league_group_id"
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
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "role", default: "client"
    t.string "user_photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "authentication_token"
    t.string "jti", null: false
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "competitions", "users"
  add_foreign_key "error_leading_to_goals", "match_goals"
  add_foreign_key "error_leading_to_goals", "matches"
  add_foreign_key "error_leading_to_goals", "players"
  add_foreign_key "error_leading_to_goals", "teams"
  add_foreign_key "error_leading_to_goals", "users"
  add_foreign_key "follows", "users"
  add_foreign_key "follows", "users", column: "followed_user_id"
  add_foreign_key "follows", "users", column: "following_user_id"
  add_foreign_key "formation_positions", "formations"
  add_foreign_key "game_weeks", "leagues"
  add_foreign_key "game_weeks", "seasons"
  add_foreign_key "game_weeks", "users"
  add_foreign_key "league_groups", "leagues"
  add_foreign_key "league_groups", "users"
  add_foreign_key "leagues", "users"
  add_foreign_key "lineup_players", "formation_positions"
  add_foreign_key "lineup_players", "match_lineups"
  add_foreign_key "lineup_players", "players"
  add_foreign_key "lineup_players", "users"
  add_foreign_key "lineup_positions", "formations"
  add_foreign_key "lineup_positions", "users"
  add_foreign_key "lineup_substitute_options", "match_lineups"
  add_foreign_key "lineup_substitute_options", "players", column: "substitute_player_id"
  add_foreign_key "lineup_substitute_options", "teams"
  add_foreign_key "lineup_substitute_options", "users"
  add_foreign_key "managers", "users"
  add_foreign_key "match_blocks", "matches"
  add_foreign_key "match_blocks", "players"
  add_foreign_key "match_blocks", "players", column: "opponent_id"
  add_foreign_key "match_blocks", "teams"
  add_foreign_key "match_blocks", "users"
  add_foreign_key "match_clearances", "matches"
  add_foreign_key "match_clearances", "players"
  add_foreign_key "match_clearances", "teams"
  add_foreign_key "match_clearances", "users"
  add_foreign_key "match_corners", "matches"
  add_foreign_key "match_corners", "players", column: "corner_taker_id"
  add_foreign_key "match_corners", "teams"
  add_foreign_key "match_corners", "users"
  add_foreign_key "match_dribbles", "matches"
  add_foreign_key "match_dribbles", "players"
  add_foreign_key "match_dribbles", "players", column: "opponent_id"
  add_foreign_key "match_dribbles", "teams"
  add_foreign_key "match_dribbles", "users"
  add_foreign_key "match_duels", "matches"
  add_foreign_key "match_duels", "players"
  add_foreign_key "match_duels", "teams"
  add_foreign_key "match_duels", "users"
  add_foreign_key "match_events", "matches"
  add_foreign_key "match_events", "players"
  add_foreign_key "match_events", "teams"
  add_foreign_key "match_events", "users"
  add_foreign_key "match_fouls", "matches"
  add_foreign_key "match_fouls", "players"
  add_foreign_key "match_fouls", "teams"
  add_foreign_key "match_fouls", "users"
  add_foreign_key "match_goals", "match_shots"
  add_foreign_key "match_goals", "matches"
  add_foreign_key "match_goals", "players", column: "assister_id"
  add_foreign_key "match_goals", "players", column: "scorer_id"
  add_foreign_key "match_goals", "teams"
  add_foreign_key "match_goals", "users"
  add_foreign_key "match_interceptions", "match_passes"
  add_foreign_key "match_interceptions", "matches"
  add_foreign_key "match_interceptions", "players"
  add_foreign_key "match_interceptions", "teams"
  add_foreign_key "match_interceptions", "users"
  add_foreign_key "match_lineups", "formations"
  add_foreign_key "match_lineups", "matches"
  add_foreign_key "match_lineups", "users"
  add_foreign_key "match_official_for_matches", "match_officials"
  add_foreign_key "match_official_for_matches", "matches"
  add_foreign_key "match_official_for_matches", "users"
  add_foreign_key "match_officials", "users"
  add_foreign_key "match_offsides", "matches"
  add_foreign_key "match_offsides", "players"
  add_foreign_key "match_offsides", "teams"
  add_foreign_key "match_offsides", "users"
  add_foreign_key "match_passes", "matches"
  add_foreign_key "match_passes", "players"
  add_foreign_key "match_passes", "players", column: "assister"
  add_foreign_key "match_passes", "players", column: "receiver"
  add_foreign_key "match_passes", "teams"
  add_foreign_key "match_passes", "users"
  add_foreign_key "match_shots", "players", column: "assist_player_id"
  add_foreign_key "match_shots", "users"
  add_foreign_key "match_substitutions", "matches"
  add_foreign_key "match_substitutions", "players", column: "substitution_player_in_id"
  add_foreign_key "match_substitutions", "players", column: "substitution_player_out_id"
  add_foreign_key "match_substitutions", "users"
  add_foreign_key "match_tackles", "matches"
  add_foreign_key "match_tackles", "players"
  add_foreign_key "match_tackles", "teams"
  add_foreign_key "match_tackles", "users"
  add_foreign_key "match_touches", "matches"
  add_foreign_key "match_touches", "players"
  add_foreign_key "match_touches", "teams"
  add_foreign_key "match_touches", "users"
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
  add_foreign_key "players", "leagues"
  add_foreign_key "players", "teams", column: "current_team_id"
  add_foreign_key "players", "users"
  add_foreign_key "posts", "leagues"
  add_foreign_key "posts", "players"
  add_foreign_key "posts", "teams"
  add_foreign_key "posts", "users"
  add_foreign_key "referees", "users"
  add_foreign_key "season_managers", "managers"
  add_foreign_key "season_managers", "seasons"
  add_foreign_key "season_managers", "teams"
  add_foreign_key "season_managers", "users"
  add_foreign_key "seasons", "users"
  add_foreign_key "stadiums", "teams"
  add_foreign_key "stadiums", "users"
  add_foreign_key "substitutions", "matches"
  add_foreign_key "substitutions", "players", column: "player_in_id"
  add_foreign_key "substitutions", "players", column: "player_out_id"
  add_foreign_key "substitutions", "teams"
  add_foreign_key "substitutions", "users"
  add_foreign_key "team_shots", "matches"
  add_foreign_key "team_shots", "teams"
  add_foreign_key "team_shots", "users"
  add_foreign_key "team_stats", "leagues"
  add_foreign_key "team_stats", "teams"
  add_foreign_key "team_stats", "users"
  add_foreign_key "teams", "league_groups"
  add_foreign_key "teams", "leagues"
  add_foreign_key "teams", "users"
  add_foreign_key "trophies", "leagues"
  add_foreign_key "trophies", "teams"
  add_foreign_key "trophies", "users"
  add_foreign_key "trophy_players", "players"
  add_foreign_key "trophy_players", "trophies"
end
