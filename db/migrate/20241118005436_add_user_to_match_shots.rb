class AddUserToMatchShots < ActiveRecord::Migration[7.0]
  def change
    add_reference :match_shots, :user, null: false, foreign_key: true
  end
end
