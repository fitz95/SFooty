class CreateLeagues < ActiveRecord::Migration[7.0]
  def change
    create_table :leagues do |t|
      t.string :league_name
      t.string :country
      t.integer :tier_level
      t.string :description
      t.string :league_photo
      t.integer :user_id

      t.timestamps
    end
    add_index :leagues, :user_id
    add_foreign_key :leagues, :users, column: :user_id
  end
end
