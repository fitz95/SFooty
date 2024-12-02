class UpdateMatchLineupsTable < ActiveRecord::Migration[7.0]
  def change

    add_reference :match_lineups, :team, null: false
    add_column :match_lineups, :expected_match_lineup, :string, array: true, default: []

    add_index :match_lineups, [:match_id, :team_id, :formation_id], unique: true, name: 'index_match_lineups_on_match_team_formation'
  end
end
