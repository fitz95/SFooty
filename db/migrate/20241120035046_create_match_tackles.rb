class CreateMatchTackles < ActiveRecord::Migration[7.0]
  def change
    create_table :match_tackles do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :tackle_type
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :minute
      t.boolean :successful
      t.boolean :last_man
      t.boolean :resulted_in_foul
      t.string :resulted_in_card
      t.string :tackle_outcome

      t.timestamps
    end
  end
end
