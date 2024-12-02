class CreateErrorLeadingToGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :error_leading_to_goals do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :match_goal, null: false, foreign_key: true 
      t.string :error_type
      t.integer :minute
      t.integer :additional_time
      t.text :description

      t.timestamps
    end
  end
end
