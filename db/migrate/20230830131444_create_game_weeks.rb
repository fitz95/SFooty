class CreateGameWeeks < ActiveRecord::Migration[7.0]
  def change
    create_table :game_weeks do |t|
      t.integer :league_id
      t.integer :week_number
      t.integer :season
      t.date :start_date
      t.date :end_date
      t.integer :user_id

      t.timestamps
    end
    add_index :game_weeks, :league_id
    add_foreign_key :game_weeks, :leagues, column: :league_id
    add_index :game_weeks, :user_id
    add_foreign_key :game_weeks, :users, column: :user_id
  end
end
