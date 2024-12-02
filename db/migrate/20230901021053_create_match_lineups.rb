class CreateMatchLineups < ActiveRecord::Migration[7.0]
  def change
    create_table :match_lineups do |t|
      t.integer :match_id
      t.integer :formation_id
      t.string :lineup_name
      t.string :comments
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :match_lineups, :matches, column: :match_id
    add_foreign_key :match_lineups, :formations, column: :formation_id
    add_foreign_key :match_lineups, :users, column: :user_id
    add_index :match_lineups, :user_id
    add_index :match_lineups, :formation_id
    add_index :match_lineups, :match_id
  end
end
