class CreateSubstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :substitutions do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player_in, null: false, foreign_key: { to_table: :players }
      t.references :player_out, null: false, foreign_key: { to_table: :players }
      t.integer :minute_in, null: false
      t.integer :minute_out, default: 90
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
