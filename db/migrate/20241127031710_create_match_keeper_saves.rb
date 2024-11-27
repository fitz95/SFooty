class CreateMatchKeeperSaves < ActiveRecord::Migration[7.0]
  def change
    create_table :match_keeper_saves do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.string :save_type
      t.integer :minute
      t.integer :additional_time
      t.string :location_on_pitch
      t.string :save_outcome
      t.text :description
      t.string :shot_taker

      t.timestamps
    end
  end
end
