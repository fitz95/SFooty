class CreateFormations < ActiveRecord::Migration[7.0]
  def change
    create_table :formations do |t|
      t.string :formation_name
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
