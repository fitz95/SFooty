class CreatePlayerInjuries < ActiveRecord::Migration[7.0]
  def change
    create_table :player_injuries do |t|
      t.integer :player_id
      t.string :injury_type
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :recovery_status
      t.integer :user_id

      t.timestamps
    end
    add_index :player_injuries, :player_id
    add_foreign_key :player_injuries, :players, column: :player_id
    add_foreign_key :player_injuries, :users, column: :user_id
    add_index :player_injuries, :user_id
  end
end
