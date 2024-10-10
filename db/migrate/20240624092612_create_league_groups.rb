class CreateLeagueGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :league_groups do |t|
      t.references :league, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
