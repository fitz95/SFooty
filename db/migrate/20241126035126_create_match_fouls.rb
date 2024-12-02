class CreateMatchFouls < ActiveRecord::Migration[7.0]
  def change
    create_table :match_fouls do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :fouled_player_id, foreign_key: { to_table: :players }, index: true
      t.integer :fouled_official_id, foreign_key: { to_table: :match_officials }, index: true
      t.string :foul_type
      t.string :severity
      t.string :card_issued
      t.integer :tackle_id
      t.integer :minute
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :opposing_team
      t.boolean :penalty_awarded
      t.text :description

      t.timestamps
    end
  end
end
