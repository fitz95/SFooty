class CreatePlayerTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :player_transfers do |t|
      t.integer :player_id
      t.integer :from_team_id
      t.integer :to_team_id
      t.date :transfer_date
      t.float :transfer_fee
      t.string :transfer_type
      t.string :transfer_window
      t.string :transfer_status
      t.string :transfer_contract
      t.string :transfer_contract_duration
      t.string :transfer_contract_salary
      t.string :transfer_contract_bonus
      t.string :transfer_contract_clause
      t.string :transfer_contract_release_clause
      t.string :transfer_contract_agent_fee
      t.string :transfer_contract_agent
      t.integer :user_id

      t.timestamps
    end
    add_index :player_transfers, :player_id
    add_foreign_key :player_transfers, :players, column: :player_id
    add_foreign_key :player_transfers, :teams, column: :from_team_id
    add_foreign_key :player_transfers, :teams, column: :to_team_id
    add_foreign_key :player_transfers, :users, column: :user_id
    add_index :player_transfers, :user_id
  end
end
