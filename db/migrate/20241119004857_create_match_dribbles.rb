class CreateMatchDribbles < ActiveRecord::Migration[7.0]
  def change
    create_table :match_dribbles do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :opponent, foreign_key: { to_table: :players }
      t.integer :minute
      t.boolean :is_successful
      t.string :dribble_type #e.g "nutmeg", "through", "around", "stepover"
      t.string :outcome  # e.g., "assist", "goal", "blocked", "intercepted", "out of bounds"

      t.decimal :x
      t.decimal :y

      t.timestamps
    end
  end
end
