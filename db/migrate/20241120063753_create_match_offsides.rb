class CreateMatchOffsides < ActiveRecord::Migration[7.0]
  def change
    create_table :match_offsides do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :minute
      t.integer :last_man, foreign_key: { to_table: :players }, index: true
      t.boolean :resulted_in_goal, default: false
      t.string :opposing_team, foreign_key: { to_table: :teams }

      t.timestamps
    end
  end
end
