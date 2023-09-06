class CreateTrophyPlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :trophy_players do |t|
      t.references :trophy, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
