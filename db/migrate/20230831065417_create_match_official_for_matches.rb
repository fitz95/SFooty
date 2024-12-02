class CreateMatchOfficialForMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :match_official_for_matches do |t|
      t.integer :match_official_id
      t.integer :match_id
      t.string :role
      t.integer :user_id

      t.timestamps
    end
    add_index :match_official_for_matches, :match_official_id
    add_foreign_key :match_official_for_matches, :match_officials, column: :match_official_id
    add_foreign_key :match_official_for_matches, :matches, column: :match_id
    add_foreign_key :match_official_for_matches, :users, column: :user_id
    add_index :match_official_for_matches, :user_id
    
  end
end
