class CreateMatchShots < ActiveRecord::Migration[7.0]
  def change
    create_table :match_shots do |t|
      t.integer :match_id
      t.integer :player_id
      t.integer :team_id
      t.integer :minute_shot
      t.boolean :is_on_target
      t.integer :user_id

      t.timestamps
    end
  end
end
