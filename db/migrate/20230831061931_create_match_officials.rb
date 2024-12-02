class CreateMatchOfficials < ActiveRecord::Migration[7.0]
  def change
    create_table :match_officials do |t|
      t.string :first_name
      t.string :last_name
      t.string :nationality
      t.date :date_of_birth
      t.string :official_photo
      t.integer :user_id

      t.timestamps
    end
    add_index :match_officials, :user_id
    add_foreign_key :match_officials, :users, column: :user_id
  end
end
