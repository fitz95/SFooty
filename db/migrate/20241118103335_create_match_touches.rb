class CreateMatchTouches < ActiveRecord::Migration[7.0]
  def change
    create_table :match_touches do |t|
      t.references :match, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :touch_type
      t.string :touch_direction
      t.boolean :successful, default: false
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.integer :minute
      t.boolean :in_box, default: false

      t.timestamps
    end
  end
end
