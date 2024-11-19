class CreateMatchBlocks < ActiveRecord::Migration[7.0]
  def change
    create_table :match_blocks do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :opponent, null: false, foreign_key: true
      t.boolean :is_successful
      t.string :block_type
      t.integer :minute
      t.decimal :x
      t.decimal :y
      t.string :block_outcome
      t.integer :distance

      t.timestamps
    end
  end
end
