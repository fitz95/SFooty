class CreateReferees < ActiveRecord::Migration[7.0]
  def change
    create_table :referees do |t|
      t.string :first_name
      t.string :last_name
      t.string :nationality
      t.date :date_of_birth
      t.integer :experience_years
      t.string :referee_photo
      t.integer :user_id

      t.timestamps
    end
    add_index :referees, :user_id
    add_foreign_key :referees, :users, column: :user_id
  end
end
