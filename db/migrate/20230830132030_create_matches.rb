class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.date :date
      t.string :time
      t.integer :stadium_id
      t.integer :referee_id
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :home_team_score
      t.integer :away_team_score
      t.integer :league_id
      t.integer :game_week_id
      t.integer :user_id

      t.timestamps
    end
  end
end
