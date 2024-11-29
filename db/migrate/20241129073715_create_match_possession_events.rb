class CreateMatchPossessionEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :match_possession_events do |t|
      t.references :match, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.string :possession_start_zone
      t.string :possession_end_zone
      t.string :possession_direction
      t.string :possession_type
      t.decimal :attacking_threat
      t.decimal :conceding_threat
      t.boolean :is_goal, default: false
      t.boolean chance_created, default: false
      t.integer :additional_time. default: false
      t.text :description

      t.timestamps
    end
  end
end
