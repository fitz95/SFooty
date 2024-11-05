class CreateSeasonManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :season_managers do |t|
      t.string :role
      t.decimal :performance_rating
      t.date :season_start_date
      t.date :season_end_date
      t.integer :goals
      t.decimal :bonuses
      t.text :contract_terms
      t.string :status
      t.text :team_performance_notes
      t.string :training_style
      t.string :most_used_formation
      t.string :most_improved_player
      t.boolean :relegated
      t.boolean :promoted

      t.references :season, null:false, foreign_key: true
      t.references :manager, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true


      t.timestamps
    end
  end
end
