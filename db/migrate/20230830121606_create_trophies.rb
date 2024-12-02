class CreateTrophies < ActiveRecord::Migration[7.0]
  def change
    create_table :trophies do |t|
      t.string :trophy_name
      t.integer :year
      t.string :trophy_photo
      t.integer :team_id
      t.integer :league_id
      t.integer :user_id

      t.timestamps
    end
    add_index :trophies, :team_id
    add_foreign_key :trophies, :teams, column: :team_id
    add_index :trophies, :league_id
    add_foreign_key :trophies, :leagues, column: :league_id
    add_index :trophies, :user_id
    add_foreign_key :trophies, :users, column: :user_id
  end
end
