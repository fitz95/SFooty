class CreateMatchClearances < ActiveRecord::Migration[7.0]
  def change
    create_table :match_clearances do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.string :clearance_type
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :minute
      t.boolean :successful
      t.boolean :under_pressure, default: true
      t.boolean :resulted_in_corner, default: false
      t.boolean :resulted_in_throw_in, default: false
      t.boolean :resulted_in_goal, default: false

      t.timestamps
    end
  end
end
