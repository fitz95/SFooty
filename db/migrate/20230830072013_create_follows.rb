class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.integer :following_user_id
      t.integer :followed_user_id
      t.integer :user_id
      t.timestamp :created_at

      t.timestamps
    end
    add_index :follows, :user_id
    add_foreign_key :follows, :users, column: :user_id
    add_foreign_key :follows, :users, column: :following_user_id
    add_foreign_key :follows, :users, column: :followed_user_id
  end
end
