class CreateTeamShots < ActiveRecord::Migration[7.0]
  def change
    create_table :team_shots do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :total_shots
      t.integer :shots_on_target
      t.integer :user_id

      t.timestamps
    end
    add_index :team_shots, :match_id
    add_foreign_key :team_shots, :matches, column: :match_id
    add_index :team_shots, :team_id
    add_foreign_key :team_shots, :teams, column: :team_id
    add_index :team_shots, :user_id
    add_foreign_key :team_shots, :users, column: :user_id
  end
end
