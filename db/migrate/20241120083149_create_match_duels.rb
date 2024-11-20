class CreateMatchDuels < ActiveRecord::Migration[7.0]
  def change
    create_table :match_duels do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.integer :opponent_player_id, foreign_key: { to_table: :players }, index: true
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :minute
      t.string :duel_type
      t.boolean :aerial
      t.boolean :ground
      t.boolean :last_man
      t.string :outcome

      t.boolean :successful

      t.timestamps
    end
  end
end
