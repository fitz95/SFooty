class UpdateMatchGoalsTable < ActiveRecord::Migration[7.0]
  def change
    # Rename columns
    rename_column :match_goals, :scorer_player_id, :scorer_id
    rename_column :match_goals, :assister_player_id, :assister_id
    rename_column :match_goals, :minute_scored, :minute
    rename_column :match_goals, :penaly_goal, :is_penalty
    rename_column :match_goals, :own_goal, :is_own_goal

    # Remove columns
    remove_column :match_goals, :team_for_id, :integer
    remove_column :match_goals, :team_against_id, :integer

    # Add new references and columns
    add_reference :match_goals, :match_shot, foreign_key: true unless column_exists?(:match_goals, :match_shot_id)
    add_reference :match_goals, :team, foreign_key: true unless column_exists?(:match_goals, :team_id)

    add_column :match_goals, :x, :decimal, precision: 5, scale: 2 unless column_exists?(:match_goals, :x)
    add_column :match_goals, :y, :decimal, precision: 5, scale: 2 unless column_exists?(:match_goals, :y)
    add_column :match_goals, :expected_goal_value, :decimal, precision: 4, scale: 3 unless column_exists?(:match_goals, :expected_goal_value)

    # Change default values
    change_column_default :match_goals, :is_own_goal, from: nil, to: false
    change_column_default :match_goals, :is_penalty, from: nil, to: false

    # Add indices only if they don't already exist
    add_index :match_goals, :scorer_id unless index_exists?(:match_goals, :scorer_id)
    add_index :match_goals, :assister_id unless index_exists?(:match_goals, :assister_id)
    add_index :match_goals, :match_shot_id unless index_exists?(:match_goals, :match_shot_id)
  end
end
