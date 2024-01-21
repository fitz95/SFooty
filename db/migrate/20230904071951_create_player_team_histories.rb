class CreatePlayerTeamHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :player_team_histories do |t|
      t.integer :player_id
      t.integer :team_id
      t.integer :start_year
      t.integer :end_year
      t.integer :user_id

      t.timestamps
    end

    add_foreign_key :player_team_histories, :players, column: :player_id
    add_foreign_key :player_team_histories, :teams, column: :team_id
    add_foreign_key :player_team_histories, :users, column: :user_id
    add_index :player_team_histories, :player_id
    add_index :player_team_histories, :team_id
    add_index :player_team_histories, :user_id
  end
end
