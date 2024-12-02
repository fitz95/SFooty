class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :photo
      t.integer :user_id
      t.string :status
      t.integer :team_id
      t.integer :player_id
      t.integer :league_id

      t.timestamps
    end
    add_index :posts, :user_id
    add_foreign_key :posts, :users, column: :user_id
    add_foreign_key :posts, :teams, column: :team_id
    add_foreign_key :posts, :players, column: :player_id
    add_foreign_key :posts, :leagues, column: :league_id
  end
end
