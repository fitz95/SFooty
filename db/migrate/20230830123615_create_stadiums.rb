class CreateStadiums < ActiveRecord::Migration[7.0]
  def change
    create_table :stadiums do |t|
      t.string :stadium_name
      t.string :city
      t.string :country
      t.integer :capacity
      t.integer :year_opened
      t.string :stadium_photo
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
    add_index :stadiums, :team_id
    add_foreign_key :stadiums, :teams, column: :team_id
    add_index :stadiums, :user_id
    add_foreign_key :stadiums, :users, column: :user_id
  end
end
