class CreateMatchInterceptions < ActiveRecord::Migration[7.0]
  def change
    create_table :match_interceptions do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :match_pass, foreign_key: true
      t.string :interception_type
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.string :interception_outcome
      t.integer :minute
      t.boolean :successful

      t.timestamps
    end
  end
end
