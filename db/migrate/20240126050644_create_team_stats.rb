class CreateTeamStats < ActiveRecord::Migration[7.0]
  def change
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

      t.index ["team_id"], name: "index_team_stats_on_team_id"
      t.index ["league_id"], name: "index_team_stats_on_league_id"
      t.index ["user_id"], name: "index_team_stats_on_user_id"
    end

    add_foreign_key "team_stats", "teams"
    add_foreign_key "team_stats", "leagues"
    add_foreign_key "team_stats", "users"
  end
end

