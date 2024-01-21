class CreateLineupSubstituteOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :lineup_substitute_options do |t|
      t.integer :match_lineup_id
      t.integer :team_id
      t.integer :substitute_player_id
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :lineup_substitute_options, :match_lineups, column: :match_lineup_id
    add_foreign_key :lineup_substitute_options, :teams, column: :team_id
    add_foreign_key :lineup_substitute_options, :players, column: :substitute_player_id
    add_foreign_key :lineup_substitute_options, :users, column: :user_id
    add_index :lineup_substitute_options, :match_lineup_id
    add_index :lineup_substitute_options, :team_id
    add_index :lineup_substitute_options, :substitute_player_id
    add_index :lineup_substitute_options, :user_id

  end
end
