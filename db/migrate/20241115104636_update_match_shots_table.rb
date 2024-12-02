class UpdateMatchShotsTable < ActiveRecord::Migration[7.0]
  def change
    change_table :match_shots do |t|
      # Adding new references only if they do not exist
      unless column_exists?(:match_shots, :assist_player_id)
        t.references :assist_player, foreign_key: { to_table: :players }, index: true
      end

      # Add new columns only if they do not exist
      t.string :shot_type, null: false, default: 'unknown' unless column_exists?(:match_shots, :shot_type)
      t.string :shot_outcome, null: false, default: 'off target' unless column_exists?(:match_shots, :shot_outcome)
      t.boolean :is_goal, default: false unless column_exists?(:match_shots, :is_goal)
      t.boolean :is_on_target, default: false unless column_exists?(:match_shots, :is_on_target)
      t.decimal :x, precision: 5, scale: 2, default: 0.0 unless column_exists?(:match_shots, :x)
      t.decimal :y, precision: 5, scale: 2, default: 0.0 unless column_exists?(:match_shots, :y)
      t.decimal :expected_goal_value, precision: 4, scale: 3, default: 0.0 unless column_exists?(:match_shots, :expected_goal_value)
    end

    # Rename the existing column only if it exists and the target column doesn't already exist
    if column_exists?(:match_shots, :minute_shot) && !column_exists?(:match_shots, :minute)
      rename_column :match_shots, :minute_shot, :minute
    end
  end
end
