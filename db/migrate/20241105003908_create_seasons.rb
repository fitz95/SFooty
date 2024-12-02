class CreateSeasons < ActiveRecord::Migration[7.0]
  def change
    create_table :seasons do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :status
      t.integer :number_of_teams
      t.string :season_type
      t.string :description
      t.integer :total_matches

      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
