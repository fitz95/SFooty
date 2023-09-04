class CreateMatchGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :match_goals do |t|
      t.integer :match_id
      t.integer :scorer_player_id
      t.integer :assister_player_id
      t.integer :team_for_id
      t.integer :team_against_id
      t.boolean penaly_goal
      t.boolean own_goal
      t.string :goal_type
      t.string :goal_desc
      t.integer :minute_scored
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :match_goals, :matches, column: :match_id
    add_foreign_key :match_goals, :players, column: :scorer_player_id
    add_foreign_key :match_goals, :players, column: :assist_player_id
    add_foreign_key :match_goals, :teams, column: :team_for_id
    add_foreign_key :match_goals, :users, column: :user_id
    add_index :match_goals, :user_id
    add_index :match_goals, :match_id
  end
end
