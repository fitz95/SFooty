class CreateMatchKeeperSaves < ActiveRecord::Migration[7.0]
  def change
    create_table :match_keeper_saves do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :save_type
      t.boolean :is_penalty_save
      t.boolean :is_ground
      t.boolean :is_aerial
      t.string :body_part # Body part used to make the save
      t.boolean :is_close_range_save, default: false
      t.boolean :is_one_on_one_save, default: false
      t.boolean :is_reaction_save, default: false
      t.float :xgp # Expected Goals prevented(xGP) on target
      t.integer :minute
      t.integer :additional_time, default: 0
      t.string :location_on_pitch
      t.float :distance_from_goal
      t.string :save_outcome
      t.text :description
      t.integer :shot_taker_id, foreign_key: { to_table: :players }, index: true

      t.timestamps
    end
  end
end
