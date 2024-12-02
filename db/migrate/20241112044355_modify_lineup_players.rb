class ModifyLineupPlayers < ActiveRecord::Migration[7.0]
  def change
    change_table :lineup_players do |t|
      # Add new columns if they don't already exist
      t.references :formation_position, null: false, foreign_key: true unless column_exists?(:lineup_players, :formation_position_id)
      t.string :position unless column_exists?(:lineup_players, :position)
      t.boolean :is_captain, default: false unless column_exists?(:lineup_players, :is_captain)
      t.boolean :is_substitute, default: false unless column_exists?(:lineup_players, :is_substitute)

      # Remove the old column if it exists
      t.remove :lineup_position_id if column_exists?(:lineup_players, :lineup_position_id)
    end

    # Add foreign keys only if they do not already exist
    add_foreign_key :lineup_players, :players unless foreign_key_exists?(:lineup_players, :players)
    add_foreign_key :lineup_players, :users unless foreign_key_exists?(:lineup_players, :users)
  end
end

