class CreateLineupPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :lineup_positions do |t|
      t.integer :formation_id
      t.string :position_name
      t.integer :position_order
      t.integer :user_id

      t.timestamps
    end
    add_index :lineup_positions, :formation_id
    add_foreign_key :lineup_positions, :formations, column: :formation_id
    add_index :lineup_positions, :user_id
    add_foreign_key :lineup_positions, :users, column: :user_id
  end
end
