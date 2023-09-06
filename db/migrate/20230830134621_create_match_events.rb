class CreateMatchEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :match_events do |t|
      t.integer :match_id
      t.string :event_type
      t.text :event_description
      t.integer :event_minute
      t.integer :player_id
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
    add_foreign_key :match_events, :matches, column: :match_id
    add_foreign_key :match_events, :players, column: :player_id
    add_foreign_key :match_events, :teams, column: :team_id
    add_foreign_key :match_events, :users, column: :user_id
    add_index :match_events, :match_id
    add_index :match_events, :player_id
    add_index :match_events, :team_id
    add_index :match_events, :user_id
  end
end
