class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :player_name
      t.string :nationality
      t.date :date_of_birth
      t.float :player_height
      t.float :player_weight
      t.integer :player_shirt_number
      t.string :player_photo
      t.integer :current_team_id
      t.integer :user_id

      t.timestamps
    end
    add_index :players, :user_id
    add_foreign_key :players, :users, column: :user_id
    add_foreign_key :players, :teams, column: :current_team_id
  end
end
