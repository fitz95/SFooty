class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email, null: false
      t.string :role, default: "client"
      t.string :user_photo
      t.timestamp :created_at

      t.timestamps
    end
  end
end
