class CreateManagers < ActiveRecord::Migration[7.0]
  def change
    create_table :managers do |t|
      t.string :name
      t.date :date_of_birth
      t.string :nationality
      t.integer :experience_level
      t.date :hired_on
      t.date :contract_end_date
      t.decimal :salary
      t.text :achievements
      t.string :manager_type
      t.string :previous_teams

      t.references :user, null: false, foreign_key: true


      t.timestamps
    end
  end
end
