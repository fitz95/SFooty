class CreateLineupPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :lineup_players do |t|
      t.integer :match_lineup_id
      t.integer :lineup_position_id
      t.integer :player_id
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :lineup_players, :match_lineups, column: :match_lineup_id
    add_foreign_key :lineup_players, :lineup_positions, column: :lineup_position_id
    add_foreign_key :lineup_players, :players, column: :player_id
    add_foreign_key :lineup_players, :users, column: :user_id
    add_index :lineup_players, :match_lineup_id
  end
end
