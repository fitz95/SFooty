class CreateMatchCorners < ActiveRecord::Migration[7.0]
  def change
    create_table :match_corners do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :corner_taker, foreign_key: { to_table: :players }, index: true
      t.references :user, null: false, foreign_key: true
      t.integer :minute
      t.string :outcome
      t.string :side


      t.timestamps
    end
  end
end
