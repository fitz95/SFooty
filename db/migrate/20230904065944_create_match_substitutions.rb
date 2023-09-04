class CreateMatchSubstitutions < ActiveRecord::Migration[7.0]
  def change
    create_table :match_substitutions do |t|
      t.integer :match_id
      t.integer :substitution_player_in_id
      t.integer :substitution_player_out_id
      t.integer :minute_substituted
      t.integer :user_id

      t.timestamps
    end

    add_foreign_key :match_substitutions, :matches, column: :match_id
    add_foreign_key :match_substitutions, :players, column: :substitution_player_in_id
    add_foreign_key :match_substitutions, :players, column: :substitution_player_out_id
    add_foreign_key :match_substitutions, :users, column: :user_id
    add_index :match_substitutions, :user_id
    add_index :match_substitutions, :match_id
  end
end
