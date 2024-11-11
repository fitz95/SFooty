class CreateFormationPositions < ActiveRecord::Migration[7.0]
  def change
    create_table :formation_positions do |t|
      t.references :formation, null: false, foreign_key: true
      t.string :position_name
      t.integer :position_order
      t.integer :position_number

      t.timestamps
    end
  end
end
