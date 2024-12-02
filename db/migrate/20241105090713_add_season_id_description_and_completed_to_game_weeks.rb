class AddSeasonIdDescriptionAndCompletedToGameWeeks < ActiveRecord::Migration[7.0]
  def change
    change_table :game_weeks do |t|
      t.references :season, null: false, foreign_key: true
      t.text :description
      t.boolean :completed, default: false
    end
  end
end
