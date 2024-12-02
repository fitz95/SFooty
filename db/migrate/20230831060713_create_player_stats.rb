class CreatePlayerStats < ActiveRecord::Migration[7.0]
  def change
    create_table :player_stats do |t|
      t.integer :player_id
      t.integer :match_id
      t.integer :goals_scored
      t.integer :assists
      t.integer :yellow_cards
      t.integer :red_cards
      t.integer :offsides
      t.integer :passes_attempted
      t.integer :passes_completed
      t.integer :dribbles_attempted
      t.integer :dribbles_completed
      t.integer :shots_conceded
      t.integer :shots_on_target
      t.integer :shots_off_target
      t.integer :saves
      t.integer :lost_possession
      t.integer :gained_possession
      t.integer :touches
      t.integer :key_passes
      t.integer :big_chance_created
      t.integer :big_chance_missed
      t.integer :clean_sheet
      t.integer :aerial_duels_won
      t.integer :aerial_duels_lost
      t.integer :ground_duels_won
      t.integer :ground_duels_lost
      t.integer :clearances
      t.integer :errors_leading_to_goal
      t.integer :errors_leading_to_shot
      t.integer :penalties_conceded
      t.integer :penalties_gained
      t.integer :fouls_committed
      t.integer :fouls_conceded
      t.integer :minutes_played
      t.string :position
      t.string :substitution_type
      t.float :player_rating
      t.integer :penalties_saved
      t.integer :user_id

      t.timestamps
    end
    add_index :player_stats, :user_id
    add_foreign_key :player_stats, :users, column: :user_id
    add_foreign_key :player_stats, :players, column: :player_id
    add_foreign_key :player_stats, :matches, column: :match_id
  end
end
