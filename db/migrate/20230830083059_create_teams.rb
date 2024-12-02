class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :country
      t.integer :founded_year
      t.references :league, null: false, foreign_key: true
      t.string :description
      t.string :coach_name
      t.string :website
      t.string :trophy_photo
      t.integer :user_id
      t.timestamps
    end
    add_index :teams, :user_id
    add_foreign_key :teams, :users, column: :user_id
  end
end
